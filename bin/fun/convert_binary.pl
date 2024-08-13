#!/usr/bin/perl -W
# No tainting, too restrictive
#!/usr/bin/perl -W -t -T

# useful commands:
# validation check
# perl -c -t -W template_boilerplate.pl
# formatting
# perltidy -b template_boilerplate.pl

# part of perlstyle: http://perldoc.perl.org/perlstyle.html
use strict;
use warnings;

use utf8;
use v5.10;

sub print_usage() {
    say "Convert to and from binary";
    say "Usage:";
    say "$0 help                             : display help";
    say "$0 bin                              : convert stdin to binary";
    say
"$0 bin 'a b c'                      : convert the string 'a b c' to binary";
    say "$0 text                             : convert stdin to text";
    say "$0 text '01100001 01100010 01100011': convert the string to text";
}

sub convert_text_to_binary {
    my @characters_list = split( //, $_[0] );
    my $output_string   = "";

    foreach my $c (@characters_list) {
        $output_string .= sprintf( "%08b", ord($c) ) . " ";
    }

    return $output_string;
}

sub convert_binary_to_text {
    my @tokens_list   = split( / /, $_[0] );
    my $output_string = "";

    foreach my $token (@tokens_list) {
        $output_string .= chr( oct( "0b" . $token ) );
    }

    return $output_string;
}

if ( !defined( $ARGV[0] ) ) {
    print_usage();
    exit 1;
}

if ( $ARGV[0] eq "help" ) {
    print_usage();
    exit 0;
}

if ( $ARGV[0] ne "bin" and $ARGV[0] ne "text" ) {
    print_usage();
    exit 1;
}

# $#ARGV = 0 if there is only one command line argument
# this will engage the STDIN mode
if ( $#ARGV == 0 ) {

    foreach (<STDIN>) {

        # removing only the final \n or \r
        $_ =~ s/\n//g;
        $_ =~ s/\r//g;

        if ( $ARGV[0] eq "bin" ) {
            say convert_text_to_binary($_);
        }

        if ( $ARGV[0] eq "text" ) {
            say convert_binary_to_text($_);
        }
    }
}
else {

    if ( $ARGV[0] eq "bin" ) {
        shift;
        foreach my $a (@ARGV) {
            say convert_text_to_binary($a);
        }
    }

    if ( $ARGV[0] eq "text" ) {
        shift;
        foreach my $a (@ARGV) {
            say convert_binary_to_text($a);
        }
    }
}

exit 0;
