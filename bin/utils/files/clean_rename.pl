#!/usr/bin/perl -W

# Not using tainting, we need to process weird input from the user.
#!/usr/bin/perl -W -t -T
#!/usr/bin/perl -W -t

######################################################################
# Rename the provided path to a cleaner name (no spaces, etc.)
# Might not work on Windows paths with backslashes...
######################################################################

# TODO: try to integrate tainting checks
# TODO: windows path support?

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

Clean Rename

=head1 SYNOPSIS

  perl clean_rename.pl  [options] [positional ...]

  perl clean_rename.pl help
  perl clean_rename.pl 'file1 space.txt' 'file2 @#! chars.txt'

=head1 DESCRIPTION

Rename the provided paths to cleaner names (no spaces, etc.)

=head1 OPTIONS

=over 4

=item B<help>

Print short usage.

POD supported for perldoc:

perldoc clean_rename.pl

=item B<filename STRING>

Target file name.

Will not be modified if already correct.

=back

=head1 SAMPLE OUPUT

  $ perl clean_rename.py /tmp/*.txt
  [ DONE ] /tmp/invalid file.txt ==> /tmp/invalid_file.txt
  [ NOOP ] /tmp/ok_file.txt

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

    for my $path (@ARGV) {
        process_file($path);
    }
}

sub print_help() {
    my $h = qq(\nRename each provided file with a more "acceptable" name\n\n);
    $h .= qq(Usage:\n);
    $h .= qq(help            : show this help and exit (see also POD)\n);
    $h .= qq(file1 file2 ... : file list\n\n);
    $h .= qq(Replace all the characters that are not "[:alnum:].-/" with "_"\n);
    $h .= qq(The "+" sign is also replaced\n);
    $h .= qq(If the name is OK do not attempt the rename\n\n);
    print $h;
}

sub process_file ($path) {

    # Some Perl documentation:
    # perldoc -f rename
    # perldoc File::Copy

    my $new_name = $path;

    # Allowed chars: a to z, A to Z, 0 to 9 and ".", "-", "/"
    # All the other chars are replaced by "_"
    $new_name =~ s/[^a-zA-Z0-9\.\-\/]/_/g;

    if ( $path eq $new_name ) {

        # Don't try to move a file to the same path.
        # The name is already correct.
        print "[ NOOP ] $path\n";
    }
    else {
        if ( rename( $path, $new_name ) ) {
            print "[ DONE ] $path ==> $new_name\n";
        }
        else {
            # Something happened during the rename/move opereration.
            print "[ FAIL ] $path ==> $new_name ==> $OS_ERROR\n";
        }
    }
}

main();
