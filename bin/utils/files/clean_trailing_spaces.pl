#!/usr/bin/perl -w -t -T
#!/usr/bin/perl -W -t -T

######################################################################
# Delete trailing spaces characters at the end of lines.
######################################################################

# TODO
# Improve the command line? use GetOptions? check for speed?
# Careful about line endings for Windows/Mac/Unix?

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

# Temp files management.
# Those modules are usually part of Perl Core.
use File::Temp ();
use File::Copy ();

######################################################################
# POD
######################################################################

=head1 NAME

Clean trailing spaces at the end of lines.

=head1 SYNOPSIS

  perl clean_trailing_spaces.pl help
  perl clean_trailing_spaces.pl files "file1.txt" "file2.txt"

=head1 DESCRIPTION

For each provided file, check if there a trailing spaces.

Trailing spaces are blank characters (space, tab, etc.).

This script creates a temporary file with the new content then
replaces the old file.

=head1 OPTIONS

=over 4

=item B<help>

Show a short help message and exit.

Also available: POD.

Use the command:

perldoc ./clean_trailing_spaces.pl

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

        # Cheap trick to avoid complaints from the tainting
        # mechanism.
        # $path should not start/end with spaces...
        if ( $path =~ m/(\S+)/ ) {
            process_file($1);
        }
    }
}

sub print_help() {
    my $h = "Clean Trailing Spaces\n\n";
    $h .= "For each provided file, check if the file has trailing spaces.\n";
    $h .= "For each file, the script cleans the lines.\n\n";
    $h .= "Options:\n\n";
    $h .= "help: Show this help and exit, see also POD.\n";
    $h .= "files file1.txt file2.txt ... fileN.txt\n\n";
    print $h;
}

sub process_file ($path) {

    # Steps:
    # - Create a temp file.
    # - Open the source file.
    # - Read every line in the source file.
    # - Delete any trailing spaces characters on each line.
    # - Write all the clean lines in the temp file.
    # - Move the temp file over the source file.

    if ( my ( $temp_fh, $temp_path ) = File::Temp::tempfile() ) {

        if ( open( my $input_fh, '<', $path ) ) {

            while ( defined( my $input_line = <$input_fh> ) ) {
                $input_line =~ s/\s+$//;
                print $temp_fh $input_line . "\n";
            }
            close $input_fh;
        }
        else {
            print STDERR "Unable to open $path for reading: $OS_ERROR\n";
            return;
        }

        close $temp_path;

        unless ( File::Copy::move( $temp_path, $path ) ) {
            print STDERR "Failure to move file: $OS_ERROR\n";
            return;
        }

        unlink $temp_path;
    }
    else {
        print STDERR "Unable to create temp file: $OS_ERROR\n";
        return;
    }
}

main();
