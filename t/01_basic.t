use strict;
use warnings;

use Test::More;

eval {
    package Foo;

    use Moo;
    use MooX::MouseTypeConstraints;

    has bar => (
        is  => 'ro',
        isa => 'Int',
    );
};
is $@, '', 'should not fail when declaring';

eval {
    package Bar;

    use Moo;
    use MooX::MouseTypeConstraints;

    has foo => (
        is  => 'ro',
        isa => 'Foo',
    );
};
is $@, '', 'should works it again';

eval {
    my $foo = Foo->new(bar => 1);
    my $bar = Bar->new(foo => $foo);
};
is $@, '', 'should not fail  construct';

eval {
    my $foo = Foo->new(bar => 'invalid');
    my $bar = Bar->new(foo => $foo);
};
isnt $@, '', 'should fail to construct with invalid Int';
note $@;

eval {
    my $foo = Foo->new(bar => 1);
    my $bar = Bar->new(foo => $foo);
    Bar->new(foo => $bar);
};
isnt $@, '', 'should fail to construct with invalid Foo';
note $@;

done_testing;
