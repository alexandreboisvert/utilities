#!/usr/bin/perl -W -t -T

######################################################################
# Check ASCII in a text file.
######################################################################

# TODO
# improve the command line? use GetOptions? check for speed?

######################################################################
# Uses
######################################################################

# Part of perlstyle: http://perldoc.perl.org/perlstyle.html
# Should be part of every program.
# Used by default on recent Perl versions.
use strict;
use warnings;

# Indicating that the script text should be UTF-8 compliant.
use utf8;

# Require a "modern" Perl installation.
# Adjust depending on what is installed on the system.
use v5.39;

# English names for most common variables in Perl.
# Makes it easier to understand the code.
# See the command "perldoc perlvar"
use English;

# Get a detailled error message on script error.
# The message contains explanations and links to reference material.
# Useful in debug/development but, causes a severe performance impact.
# use diagnostics;

######################################################################
# POD
######################################################################

=head1 NAME

Check ASCII

=head1 SYNOPSIS

  perl check_ascii.pl help
  perl check_ascii.pl files "file1.txt" "file2.txt" "file3.txt"

=head1 DESCRIPTION

For each provided file, check if the file is ASCII-only.

For each file, the script returns the offending lines.

=head1 OPTIONS

=over 4

=item B<help>

Show a short help message and exit.

Also available: POD.

Use the command:

perldoc ./check_ascii.pl

=item B<files STRING>

A list of files to process.

=back

=cut

######################################################################
# Subroutines
######################################################################

sub main() {

    if ( !scalar @ARGV ) {
        say "Arguments required, try 'help'";
        exit 1;
    }

    if ( $ARGV[0] eq "help" ) {
        print_help();
        exit 0;
    }

    if ( $ARGV[0] ne "files" ) {
        say "Incorrect arguments, try 'help'";
        exit 1;
    }

    shift @ARGV;

    if ( scalar(@ARGV) eq 0 ) {
        say "At least one file path required, see 'help'";
        exit 1;
    }

    for my $path (@ARGV) {
        process_file($path);
    }
}

sub print_help() {
    my $h = "Check ASCII\n\n";
    $h .= "For each provided file, check if the file is ASCII-only.\n";
    $h .= "For each file, the script returns the offending lines.\n\n";
    $h .= "Options:\n\n";
    $h .= "help: Show this help and exit\n";
    $h .= "files file1.txt file2.txt ... fileN.txt\n\n";
    print $h;
}

sub process_file ($path) {

    # For a given file, list the line (path, line number, line
    # content) that do not match the plain text regex.

    # Allowed chars:
    # tab (0x09),
    # line feed (0x0A),
    # carriage return (0x0D),
    # and the interval from space (0x20) to tilde (0x7E)

    if ( open( my $fhandle, '<', $path ) ) {

        my $line_count = 0;
        while ( defined( my $line = <$fhandle> ) ) {
            $line_count++;
            chomp $line;
            say "$path : $line_count : $line"
              if ( $line =~ m/[^\x09\x0A\x0D\x20-\x7E]/ );
        }

        close($fhandle);
    }
    else {
        say "process_file: failure to open $path: $OS_ERROR";
    }
}

main();
