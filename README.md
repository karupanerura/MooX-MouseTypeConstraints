[![MetaCPAN Release](https://badge.fury.io/pl/MooX-MouseTypeConstraints.svg)](https://metacpan.org/release/MooX-MouseTypeConstraints) [![Actions Status](https://github.com/karupanerura/MooX-MouseTypeConstraints/workflows/test/badge.svg)](https://github.com/karupanerura/MooX-MouseTypeConstraints/actions)
# NAME

MooX::MouseTypeConstraints - Mouse type constraints for Moo

# SYNOPSIS

    use Moo;
    use MooX::MouseTypeConstraints;

    has bar => (
        is  => 'ro',
        isa => 'Int', # make it as Mouse::Meta::TypeContraints validator
    );

# DESCRIPTION

MooX::MouseTypeConstraints provides [Mouse](https://metacpan.org/pod/Mouse) type constraints support for [Moo](https://metacpan.org/pod/Moo).

# LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

karupanerura <karupa@cpan.org>
