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
is $@, '', 'should not fail to declar';

eval {
    Foo->new(bar => 1);
};
is $@, '', 'should not fail to construct';

eval {
    Foo->new(bar => 'invalid');
};
isnt $@, '', 'should fail to construct with invalid';
note $@;

done_testing;
