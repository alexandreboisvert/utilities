#!/usr/bin/perl -W

######################################################################
# MD5 Check All - Pure Perl Version
######################################################################

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

# Command line options, usually this module is part of Perl Core.
use Getopt::Long qw(GetOptions);

# This module (Pod::Usage) is usually part of Perl Core.
# The module Pod::Usage does not play nice with the tainting
# mechanism. Making it more simple.

# Disabling Tainting Mechanism: File::Find, File::Spec do not play
# nice when tainting is enabled.
use File::Find  ();
use File::Spec  ();
use Digest::MD5 ();

# Using POSIX for time formatting.
use POSIX ();

######################################################################
# POD
######################################################################

=head1 NAME

MD5 Check All - Pure Perl Version.

=head1 SYNOPSIS

  perl md5checkall.pl --help
  perl md5checkall.pl -h

  perl md5checkall.pl --directory "/path/to/dir"
  perl md5checkall.pl -d "/path/to/dir"

=head1 DESCRIPTION

Find all the MD5 checksum files and check them.

The directory is provided by the option "-d".

If not provided, the script uses the current directory.

=head1 OPTIONS

=over 4

=item B<--directory STRING>, B<-d STRING>

Provide the directory to check.

=item B<--help>, B<-h>

Show a help message.

See also POD.

=back

=cut

######################################################################
# Subroutines
######################################################################

sub main() {

    # Keeping all the command line options in a hash for easy access.
    my %cmd_line_options = (
        directory => "",
        help      => 0,
    );

    # Passing references to the hash values
    my $options_ok = GetOptions(

        # Replace the string.
        'directory|d=s' => \$cmd_line_options{directory},

        # Show short help message.
        'help|h' => \$cmd_line_options{help},
    );

    if ( !$options_ok ) {
        print_log("Invalid options: see --help");
        exit 1;
    }

    if ( $cmd_line_options{help} ) {
        print_help();
        exit 0;
    }

    my $target_directory = "";

    if ( $cmd_line_options{directory} eq "" ) {

        # When no directory is specified, we fall back
        # to "." (current directory)
        $target_directory = ".";
    }
    else {
        $target_directory = $cmd_line_options{directory};
    }

    print_log("Processing directory $target_directory");

    # Check if the directory exists
    unless ( -d $target_directory ) {
        print_log("Error: Directory '$target_directory' does not exist.");
        exit 1;
    }

    # Use File::Find to traverse the directory
    File::Find::find(
        sub {
            my $path = $File::Find::name;
            if ( -f $path ) {
                if ( $path =~ /\.md5$/i ) {
                    my ( $volume, $directories, $basename ) =
                      File::Spec->splitpath($path);
                    chdir $directories;
                    if ( -f $basename ) {
                        my %pairs = parse_md5($basename);
                        for my $k ( sort keys %pairs ) {
                            my $computed = get_md5( $pairs{$k} );
                            if ( uc $k eq uc $computed ) {
                                print_log("[  OK  ] $pairs{$k}");
                            }
                            else {
                                print_log("[ FAIL ] $pairs{$k} in $path");
                            }
                        }
                    }
                }
            }
        },
        $target_directory
    );
}

sub get_md5($path) {

    if ( open( my $fh, '<', $path ) ) {

        binmode($fh);
        my $md5_hex = Digest::MD5->new->addfile($fh)->hexdigest;
        close($fh);
        return $md5_hex;
    }
    else {

        return "";
    }
}

sub parse_md5($path) {

    my %md5_pairs;

    return %md5_pairs unless ( open( my $fh, '<', $path ) );

    while (<$fh>) {
        chomp;

        # Two regexes: two allowed formats
        if (m/^([0-9a-fA-F]{32})\s\*(.+)$/) {
            $md5_pairs{$1} = $2;
            next;
        }

        if (m/^([0-9a-fA-F]{32})\s\s(.+)$/) {
            $md5_pairs{$1} = $2;
            next;
        }
    }

    close($fh);

    return %md5_pairs;
}

sub print_help () {

    # Print a shot message to STDERR
    my $h = "\n";
    $h .= qq(MD5 Check All - Pure Perl Version.\n\n);
    $h .= qq(SYNOPSIS\n\n);
    $h .= qq(perl md5checkall.pl [options] [positional ...]\n);
    $h .= qq(perl md5checkall.pl --help\n);
    $h .= qq(perl md5checkall.pl --directory "/path/to/dir"\n);
    $h .= qq(perl md5checkall.pl -d "/path/to/dir"\n\n);
    $h .= qq(DESCRIPTION\n\n);
    $h .= qq(Find all the MD5 checksum files and check them.\n);
    $h .= qq(The directory is provided by the option "-d".\n);
    $h .= qq(If not provided, the script uses the ");
    $h .= qq(current directory.\n\n);
    $h .= qq(OPTIONS\n\n);
    $h .= qq(--directory STRING, -d STRING>\n);
    $h .= qq(Provide the directory to check.\n\n);
    $h .= qq(--help, -h\n);
    $h .= qq(Show a help message.\n);
    $h .= qq(See also POD.\n);

    print STDERR $h;
}

sub print_log($message) {

    # localtime rounds to the second
    my $ts = POSIX::strftime( "%F %T", localtime );
    print STDERR "$ts $message\n";
}

main();
