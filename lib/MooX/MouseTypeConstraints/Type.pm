package MooX::MouseTypeConstraints::Type;
use strict;
use warnings;

use overload '&{}' => '_type_check', fallback => 1;

sub new {
    my ($class, %args) = @_;
    my $type = $args{type}
        or die q|MooX::MouseTypeConstraints::Type->new requires a `type`|;
    return bless { type => $type }, $class;
}

sub type { $_[0]->{type} }

# Moo calls the isa value as a coderef to validate a value. The check
# itself never coerces: it only accepts values that already satisfy
# the Mouse type constraint, exactly like Mouse does without
# `coerce => 1`.
sub _type_check {
    my $self = shift;
    return $self->{_type_check} ||= do {
        my $type = $self->{type};
        sub {
            die $type->get_message(@_) unless $type->check(@_);
        };
    };
}

# Moo calls this method to obtain the coerced value when an attribute
# is declared with `coerce => 1`, and stores the returned value.
sub coerce {
    my $self = shift;
    return $self->{type}->coerce(@_);
}

1;
__END__

=encoding utf-8

=head1 NAME

MooX::MouseTypeConstraints::Type - a Mouse type constraint wrapper for Moo

=head1 DESCRIPTION

This is an internal class used by L<MooX::MouseTypeConstraints>. It
wraps a L<Mouse::Meta::TypeConstraint> in an object that Moo can use
both as an C<isa> check (via the C<&{}> overload) and, when an
attribute is declared with C<coerce => 1>, as a source of coercion
(via the C<coerce> method).

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut
