#!/usr/bin/perl -W -t -T

# useful commands:
# validation check
# perl -c -t -W template_boilerplate.pl
# formatting
# perltidy -b template_boilerplate.pl

# part of perlstyle: http://perldoc.perl.org/perlstyle.html
use strict;
use warnings;
use sigtrap;
use diagnostics;

# Arguments parsing
use Getopt::Long;

######################################################################

sub print_help {
    print "\nEntropy computation\n";
    print "-h/--help          : display help and exit\n";
    print "-f/--file input.txt: input file to process\n";
    print "-s/--stdin         : process stdin instead of a file\n\n";
}

my $input_filename = "";
my $stdin_mode     = 0;
my $help_mode      = 0;
my $getoptresult   = GetOptions(
    "file=s" => \$input_filename,
    "stdin"  => \$stdin_mode,
    "help"   => \$help_mode,
);

if ($getoptresult) {
    if ($help_mode) {
        print_help();
        exit 0;
    }

    if ( $input_filename eq "" && $stdin_mode == 0 ) {
        print "Required options\n";
        print_help();
        exit 1;
    }

    if ( $input_filename ne "" && $stdin_mode == 1 ) {
        print "Incompatible options\n";
        print_help();
        exit 1;
    }

    my $byte_count      = 0.0;
    my @histogram       = (0.0) x 256;
    my $buffer          = "";
    my $entropy         = 0.0;
    my $math_log_e_of_2 = log(2.0);
    my $frequency       = 0.0;

    if ($stdin_mode) {
        print "USE STDIN\n";
        print "TODO\n";

        # TODO
    }
    else {
        my $input_filehandle;
        open( $input_filehandle, "<", $input_filename )
          or die "Not able to open the file.\n";
        binmode($input_filehandle);
        while ( ( read( $input_filehandle, $buffer, 4096 ) ) != 0 ) {
            my @bytes = split( //, $buffer );
            foreach my $byte (@bytes) {
                $histogram[ ord $byte ] += 1;
                $byte_count += 1;
            }
        }
        close($input_filehandle);
        foreach my $value (@histogram) {
            if ( $value > 0.0 ) {
                $frequency = $value / $byte_count;
                $entropy -= $frequency * ( log($frequency) / $math_log_e_of_2 );
            }
        }
        print "$entropy\n";
    }
}
else {
    print_help();
    exit 1;
}

exit 0;
