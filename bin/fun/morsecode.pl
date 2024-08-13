#!/usr/bin/perl -W -t -T

# useful commands:
# validation check
# perl -c -t -W script.pl
# formatting
# perltidy -b script.pl

# part of perlstyle: http://perldoc.perl.org/perlstyle.html
use strict;
use warnings;

# more elegant function than die: croak
use Carp;

our $VERSION = 0.1;

# ascii table from the interwebs
my %encode_to_morse = (
    q(A) => q(._),
    q(B) => q(_...),
    q(C) => q(_._.),
    q(D) => q(_..),
    q(E) => q(.),
    q(F) => q(.._.),
    q(G) => q(__.),
    q(H) => q(....),
    q(I) => q(..),
    q(J) => q(.___),
    q(K) => q(_._),
    q(L) => q(._..),
    q(M) => q(__),
    q(N) => q(_.),
    q(O) => q(___),
    q(P) => q(.__.),
    q(Q) => q(__._),
    q(R) => q(._.),
    q(S) => q(...),
    q(T) => q(_),
    q(U) => q(.._),
    q(V) => q(..._),
    q(W) => q(.__),
    q(X) => q(_.._),
    q(Y) => q(_.__),
    q(Z) => q(__..),
    q(0) => q(_____),
    q(1) => q(.____),
    q(2) => q(..___),
    q(3) => q(...__),
    q(4) => q(...._),
    q(5) => q(.....),
    q(6) => q(_....),
    q(7) => q(__...),
    q(8) => q(___..),
    q(9) => q(____.),
    q(.) => q(._._._),
    q(,) => q(__..__),
    q(:) => q(___...),
    q(?) => q(..__..),
    q(') => q(.____.),
    q(-) => q(_..._),
    q(/) => q(_.._.),
    q(") => q(._.._.),

    # converting a space to | for clarity
    q( ) => q(|),
);

my %decode_from_morse = (
    q(._)     => q(A),
    q(_...)   => q(B),
    q(_._.)   => q(C),
    q(_..)    => q(D),
    q(.)      => q(E),
    q(.._.)   => q(F),
    q(__.)    => q(G),
    q(....)   => q(H),
    q(..)     => q(I),
    q(.___)   => q(J),
    q(_._)    => q(K),
    q(._..)   => q(L),
    q(__)     => q(M),
    q(_.)     => q(N),
    q(___)    => q(O),
    q(.__.)   => q(P),
    q(__._)   => q(Q),
    q(._.)    => q(R),
    q(...)    => q(S),
    q(_)      => q(T),
    q(.._)    => q(U),
    q(..._)   => q(V),
    q(.__)    => q(W),
    q(_.._)   => q(X),
    q(_.__)   => q(Y),
    q(__..)   => q(Z),
    q(_____)  => q(0),
    q(.____)  => q(1),
    q(..___)  => q(2),
    q(...__)  => q(3),
    q(...._)  => q(4),
    q(.....)  => q(5),
    q(_....)  => q(6),
    q(__...)  => q(7),
    q(___..)  => q(8),
    q(____.)  => q(9),
    q(._._._) => q(.),
    q(__..__) => q(,),
    q(___...) => q(:),
    q(..__..) => q(?),
    q(.____.) => q('),
    q(_..._)  => q(-),
    q(_.._.)  => q(/),
    q(._.._.) => q("),
    q(|)      => q( ),
);

sub display_usage() {
    my $usage = <<'EOF';

Morse code parser
Usage: morsecode.pl encode 'sos sos'
       morsecode.pl decode '... ___ ... | ... ___ ...'

EOF
    return print "$usage\n";
}

sub process_command_line_arguments() {

    my $num_args = $#ARGV + 1;
    if ( $num_args < 2 ) {
        display_usage();
        exit 1;
    }
}

######################################################################
# Main program

process_command_line_arguments();

my $command_selected = $ARGV[0];
my $input_message    = $ARGV[1];

# stackoverflow short and sweet version
#my $message = join "", map { $morsecode{$_} // "<unknown code $_>" } @codes;

if ( $command_selected eq 'encode' or $command_selected eq 'decode' ) {
    if ( $command_selected eq 'encode' ) {

        # to encode, process each character and happen to the final string
        print "Input message: $input_message\n" or croak;

        my $output_message = q();

        foreach my $message_letter ( split //xms, $input_message ) {
            $output_message .= q( );
            if ( exists $encode_to_morse{ uc $message_letter } ) {
                $output_message .= $encode_to_morse{ uc $message_letter };
            }
            else {
                $output_message .= $message_letter;
            }
        }

        # trimming
        $output_message =~ s/^\s+|\s+$//gxms;

        print "Output message: $output_message\n" or croak;
    }
    if ( $command_selected eq 'decode' ) {

        # to decode: split in words (|) then split in characters ( )
        print "Input message: $input_message\n" or croak;

        # input conversion: - to _, / to |
        $input_message =~ s/\-/\_/gxms;
        $input_message =~ s/\//\|/gxms;

        my $output_message = q();

        foreach my $current_word ( split m{|}xms, $input_message ) {
            $output_message .= q( );
            my $output_word = q();
            foreach my $current_token ( split / /xms, $current_word ) {

                if ( exists $decode_from_morse{$current_token} ) {
                    $output_word .= $decode_from_morse{$current_token};
                }
            }
            $output_message .= $output_word;
        }

        # trimming
        $output_message =~ s/^\s+|\s+$//gxms;

        print "Output message: $output_message\n" or croak;
    }
}
else {
    print "command must be encode or decode\n" or croak;
    display_usage();
}

exit 0;
