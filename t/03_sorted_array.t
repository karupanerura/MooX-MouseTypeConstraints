use strict;
use warnings;

use Test::More;

# Regression test for https://github.com/karupanerura/MooX-MouseTypeConstraints/issues/1
# A coercible value must not be validated against its coerced form
# while the original (invalid) value is stored.

eval q{
    use Mouse::Util::TypeConstraints;

    subtype 'SortedArray'
      => as 'ArrayRef'
      => where {
        my $last;
        for my $x (@$_) {
          return 0
            if defined $last && $last > $x;
          $last = $x;
        }
        return 1;
      };

    coerce 'SortedArray'
      => from 'ArrayRef'
      => via { [ sort { $a <=> $b } @$_ ] };

    package MooExample;
    use Moo;
    use MooX::MouseTypeConstraints;
    has attr1 => (is => 'ro', isa => 'SortedArray');

    package MooCoerceExample;
    use Moo;
    use MooX::MouseTypeConstraints;
    has attr1 => (is => 'ro', isa => 'SortedArray', coerce => 1);
};
is $@, '', 'should not fail when declaring';

subtest 'without coerce => 1' => sub {
    my $o = eval { MooExample->new(attr1 => [1, 2]) };
    is $@, '', 'should accept a value that satisfies the type';
    is_deeply $o && $o->attr1, [1, 2], 'the value should be stored as-is';

    eval { MooExample->new(attr1 => [2, 1]) };
    isnt $@, '', 'should reject a value that only satisfies the type after coercion';
    note $@;
};

subtest 'with coerce => 1' => sub {
    my $o = eval { MooCoerceExample->new(attr1 => [2, 1]) };
    is $@, '', 'should accept a coercible value';
    is_deeply $o && $o->attr1, [1, 2], 'the coerced value should be stored';

    $o = eval { MooCoerceExample->new(attr1 => [1, 2]) };
    is $@, '', 'should accept a value that satisfies the type';
    is_deeply $o && $o->attr1, [1, 2], 'the value should be stored as-is';
};

done_testing;
