package MooX::MouseTypeConstraints;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Mouse::Util::TypeConstraints ();

sub import {
    my $class = shift;
    my $target = caller;

    my $has = $target->can('has');
    my $code = sub {
        my ($name, %args) = @_;
        if (exists $args{isa} && !ref $args{isa}) {
            my $type = Mouse::Util::TypeConstraints::find_type_constraint($args{isa});
            $args{isa} = sub {
                die $type->get_message(@_) unless $type->check(@_);
            };
        }
        @_ = ($name, %args);
        goto $has;
    };

    my $glob = "${target}::has";
    {
        no strict qw/refs/;
        no warnings qw/prototype redefine/;
        *{$glob} = $code;
    };
}

1;
__END__

=encoding utf-8

=head1 NAME

MooX::MouseTypeConstraints - It's new $module

=head1 SYNOPSIS

    use MooX::MouseTypeConstraints;

=head1 DESCRIPTION

MooX::MouseTypeConstraints is ...

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut

