#
#===============================================================================
#
#         FILE: Object.pm
#
#  DESCRIPTION:
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: James Tingen (jtingen), jtingen@us.ibm.com
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/14/2014 10:39:16 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Data::Dumper;
use Math::BigFloat;

package Object;

sub name {
    my $self = shift;
    return $self->{_name};
}

sub color {
    my $self = shift;
    return $self->{_color};
}

sub mass {
    my $self = shift;
    return $self->{_mass};
}

sub position {
    my $self = shift;
    return {
        x => $self->{_px},
        y => $self->{_py},
        z => $self->{_pz}
    };
}

sub velocity {
    my $self = shift;
    return {
        x => $self->{_vx},
        y => $self->{_vy},
        z => $self->{_vz}
    };
}

sub update {
    my $self    = shift;
    my $seconds = shift;
    my $f_total = shift;

    $self->{_vx}->badd(
        ( $f_total->{x}->copy->bmul($seconds)->bdiv( $self->mass ) )[0] );
    $self->{_vy}->badd(
        ( $f_total->{y}->copy->bmul($seconds)->bdiv( $self->mass ) )[0] );
    $self->{_vz}->badd(
        ( $f_total->{z}->copy->bmul($seconds)->bdiv( $self->mass ) )[0] );
    $self->{_px}->badd( $self->{_vx}->copy->bmul($seconds) );
    $self->{_py}->badd( $self->{_vy}->copy->bmul($seconds) );
    $self->{_pz}->badd( $self->{_vz}->copy->bmul($seconds) );
}

sub new {
    my $class = shift;
    my $arg   = shift;
    my $self;

    $self->{_name}  = $arg->{name}  ||= 'Null';
    $self->{_color} = $arg->{color} ||= 'grey';
    $self->{_mass}  = $arg->{mass}  ||= 1;
    $self->{_px}    = $arg->{px}    ||= 0;
    $self->{_py}    = $arg->{py}    ||= 0;
    $self->{_pz}    = $arg->{pz}    ||= 0;
    $self->{_vx}    = $arg->{vx}    ||= 0;
    $self->{_vy}    = $arg->{vy}    ||= 0;
    $self->{_vz}    = $arg->{vz}    ||= 0;

    #Convert to Math::BigFloat
    $self->{_mass} = Math::BigFloat->new( $self->{_mass} );
    $self->{_px}   = Math::BigFloat->new( $self->{_px} );
    $self->{_py}   = Math::BigFloat->new( $self->{_py} );
    $self->{_pz}   = Math::BigFloat->new( $self->{_pz} );
    $self->{_vx}   = Math::BigFloat->new( $self->{_vx} );
    $self->{_vy}   = Math::BigFloat->new( $self->{_vy} );
    $self->{_vz}   = Math::BigFloat->new( $self->{_vz} );

    bless $self, $class;
    return $self;
}

1;
