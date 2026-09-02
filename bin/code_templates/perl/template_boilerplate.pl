#!/usr/bin/perl -W -t -T
#!/usr/bin/perl -W -t

######################################################################
# Perl Template Program.
# This program contains a lot of comments.
# Some suggestions are AI generated with LLMs.
# Some suggestions come from my old scripts.
######################################################################

######################################################################
# Program options on the shebang.
######################################################################

# Documentation from: perldoc perlrun
# -W   Enables all warnings regardless of "no warnings" or $^W. See
#      warnings.
# -t   Like "-T", but taint checks will issue warnings rather than fatal
#      errors. These warnings can now be controlled normally with no
#      warnings qw(taint).
#      Note: This is not a substitute for "-T"! This is meant to be used
#      *only* as a temporary development aid while securing legacy code:
#      for real production code and for new secure code written from
#      scratch, always use the real "-T".
#      This has no effect if your perl was built without taint support.
# -T   turns on "taint" so you can test them. Ordinarily these checks are
#      done only when running setuid or setgid. It's a good idea to turn
#      them on explicitly for programs that run on behalf of someone else
#      whom you might not necessarily trust, such as CGI programs or any
#      internet servers you might write in Perl. See perlsec for details.
#      For security reasons, this option must be seen by Perl quite early;
#      usually this means it must appear early on the command line or in
#      the "#!" line for systems which support that construct.

# Reminder: The taint mechanism can be cumbersome to manage.

######################################################################
# Useful Commands
######################################################################

# Consulting the Perl Documentation.
# $ perldoc perl | less
# Some distros will need to install the package perl-doc.
# Using less as a better pager.

# Check the whole script for syntax and other errors.
# $ perl -w -W -t -T -c template_boilerplate.pl
# From perldoc perlrun:
# -c   causes Perl to check the syntax of the program and then exit
#      without executing it. Actually, it *will* execute any "BEGIN",
#      "UNITCHECK", or "CHECK" blocks and any "use" statements: these are
#      considered as occurring outside the execution of your program.
#      "INIT" and "END" blocks, however, will be skipped.
#      If the syntax check is successful perl will exit with a status of
#      zero and report "*yourprogram* syntax OK". On failure perl will
#      print any detected errors and exit with a non-zero status.

# Review and propose suggestions on the script:
# $ perlcritic --verbose 11 template_boilerplate.pl
# The default level is 5 and is OK. Level 1 is way too aggressive.
# Verbose mode 11 gives lots of details.
# The program perlcritic package is usually available in the repos.

# Format the script file.
# Using -b to get a backup file (.bak).
# $ perltidy -b template_boilerplate.pl

# List the Core Perl modules available on the system for a given
# version.
# $ corelist -v 'v5.42.0'

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
use v5.38;

# English names for most common variables in Perl.
# Makes it easier to understand the code.
# See the command "perldoc perlvar"
use English;

# Get a detailled error message on script error.
# The message contains explanations and links to reference material.
# Useful in debug/development but, causes a severe performance impact.
use diagnostics;

# When we need to catch signals (SIGUSR, etc.)
# use sigtrap;

# Command line options, usually this module is part of Perl Core.
use Getopt::Long qw(GetOptions);

# Using the already available POD documentation for command line help.
# This module is usually part of Perl Core.
use Pod::Usage qw(pod2usage);

# This module is usually part of Perl Core.
use JSON::PP;

# Useful for debugging and printing.
# This module is usually part of Perl Core.
use Data::Dumper;

######################################################################
# Constants
######################################################################

# Attempting to alter this value will fail at compile time.
use constant PI => 3.14159;

######################################################################
# POD
######################################################################

=head1 NAME

Template/Boilerplate Perl 5 Script.

=head1 SYNOPSIS

  perl template_boilerplate.pl [options] [positional ...]

  perl template_boilerplate.pl --help
  perl template_boilerplate.pl --man
  perl template_boilerplate.pl --name "ABC" --count 3 --verbose
  perl template_boilerplate.pl --demo refs

=head1 DESCRIPTION

This script is a template for Perl.

This script was inspired by Claude and various other LLMs.

This script contains examples of Perl features.


Highlights:

=over 4

=item * Best practices: C<strict>, C<warnings>, lexical variables, clear structure.

=item * Modern syntax: subroutine signatures, C<state>, C<//>, dispatch table usage.

=item * CLI parsing with C<Getopt::Long> and documentation with C<Pod::Usage>.

=item * Core data structures and references: scalars, arrays, hashes, refs, nested data.

=item * Inline comments and POD for maintainability.

=back

=head1 OPTIONS

=over 4

=item B<--name STRING>

Name used in example output. Default: C<Perl Template Program>.

=item B<--count INT>

Positive integer used by loop examples. Default: C<2>.

=item B<--verbose> / B<--no-verbose>

Enable/disable extra explanatory output.

=item B<--demo STRING>

Choose one tutorial section: C<all>, C<scalars>, C<arrays>, C<hashes>,
C<refs>, C<flow>, C<subs>, C<exec>, C<fileinfo>, C<stdin>, C<data>,
C<files>, C<bin>, C<json>.

=item B<--help>, B<-h>

Print short usage.

=item B<--man>

Print full manual (this POD).

=back

=head1 DATA STRUCTURE REMINDER

Perl sigils:

=over 4

=item * C<$scalar> - single value (number, string, reference, object, etc.)

=item * C<@array> - ordered list

=item * C<%hash> - key/value map

=back

References:

=over 4

=item * C<$arr_ref = [ ... ]> for array references

=item * C<$hash_ref = { ... }> for hash references

=item * Dereference with C<< $arr_ref->[0] >> and C<< $hash_ref->{key} >>

=back

=head1 USEFUL WEB REFERENCES

=over 4

=item * Perl documentation index: L<https://perldoc.perl.org/>

=item * perlfaq: L<https://perldoc.perl.org/perlfaq>

=item * Getopt::Long docs: L<https://perldoc.perl.org/Getopt::Long>

=item * Perl Maven tutorials: L<https://perlmaven.com/>

=item * Modern Perl book (free online): L<http://modernperlbooks.com/books/modern_perl_2016/index.html>

=item * CPAN module search: L<https://metacpan.org/>

=item * https://perl.petamem.com/docs/eng/index.html

=back

=head1 STYLE NOTES

Recommended defaults for most scripts:

=over 4

=item * Start with C<use v5.36; use strict; use warnings;>

=item * Keep subroutines focused and small.

=item * Validate input early and fail with clear messages.

=item * Prefer lexical variables and avoid package globals.

=item * Sort hash keys in output where deterministic logs matter.

=item * Write POD early so C<--help> and C<--man> stay useful.

=back

=head1 AUTHOR

Generated as a practical tutorial script for Perl 5 learners.

=head1 LICENSE

This example is provided as-is, with no warranty.

=cut

######################################################################
# Subroutines
######################################################################

sub main() {

    # Keeping all the command line options in a hash for easy access.
    my %cmd_line_options = (
        name    => "Perl Template Program",
        count   => 0,
        verbose => 0,
        demo    => "",
        help    => 0,
        man     => 0,
    );

    # Passing references to the hash values
    GetOptions(

        # Replace the string.
        'name=s' => \$cmd_line_options{name},

        # Replace the int value.
        'count=i' => \$cmd_line_options{count},

        # Store a boolean value. --verbose, --no-verbose
        'verbose!' => \$cmd_line_options{verbose},

        # Choose one option for the demo
        'demo=s' => \$cmd_line_options{demo},

        # Show short help message.
        'help|h' => \$cmd_line_options{help},

        # Show long help message (show POD).
        'man' => \$cmd_line_options{man},

        # Return code 2 on invalid arguments.
    ) or pod2usage(2);

    # Display a short version of the POD with option "help".
    pod2usage(1) if $cmd_line_options{help};

    # Display a long version of the POD with option "man".
    pod2usage( -verbose => 2, -exitval => 0 ) if $cmd_line_options{man};

    # Program entrypoint.
    print "This is main\n";

    print "Selected demo = " . $cmd_line_options{demo} . "\n";

    my $selected_demo = $cmd_line_options{demo};
    chomp $selected_demo;

    if ( $cmd_line_options{demo} =~ m/^$/ ) {
        print "The selected demo is not valid. See option --help.\n";
        exit 1;
    }

    my @list = qw(all scalars arrays hashes refs flow subs exec
      fileinfo stdin data files bin json);

    if ( grep { $ARG =~ $selected_demo } @list ) {
        print "This is a valid selected value.\n";

        demo_scalars()          if ( $selected_demo eq "scalars" );
        demo_arrays()           if ( $selected_demo eq "arrays" );
        demo_hashes()           if ( $selected_demo eq "hashes" );
        demo_refs()             if ( $selected_demo eq "refs" );
        demo_flow()             if ( $selected_demo eq "flow" );
        demo_subs()             if ( $selected_demo eq "subs" );
        demo_exec()             if ( $selected_demo eq "exec" );
        demo_fileinfo()         if ( $selected_demo eq "fileinfo" );
        demo_stdin()            if ( $selected_demo eq "stdin" );
        demo_data()             if ( $selected_demo eq "data" );
        demo_read_write_files() if ( $selected_demo eq "files" );
        demo_bin_mode()         if ( $selected_demo eq "bin" );
        demo_json()             if ( $selected_demo eq "json" );

        if ( $selected_demo eq "all" ) {
            demo_scalars();
            demo_arrays();
            demo_hashes();
            demo_refs();
            demo_flow();
            demo_subs();
            demo_exec();
            demo_fileinfo();
            demo_stdin();
            demo_data();
            demo_read_write_files();
            demo_bin_mode();
            demo_json();
        }
    }
    else {
        print "This is not a valid list item. See option --help.\n";
    }

    print "Demo program end.\n";

}

sub demo_scalars() {
    print "demo_scalars: start\n";

    my $integer = 42;
    my $float   = 3.14159;
    my $string  = "This is a string";

    print "demo_scalars: Scalars don't need strong typing.\n";
    print "demo_scalars: Integer value   = $integer\n";
    print "demo_scalars: Float value     = $float\n";
    print "demo_scalars: String value    = $string\n";

    print "demo_scalars: Can't print a constant with dollar sign,";
    print "demo_scalars: using a string concatenation instead.\n";
    print "demo_scalars: The value of PI = " . PI . "\n";

    print "demo_scalars: String operations\n";
    print "demo_scalars: Split on words with -*-\n";
    my @tokens = split( /\s+/, $string );
    print "demo_scalars: " . join( "-*-", @tokens ) . "\n";
    print "demo_scalars: Split on chars with -*-\n";
    @tokens = split( //, $string );
    print "demo_scalars: " . join( "-*-", @tokens ) . "\n";

    print "demo_scalars: end\n";
}

sub demo_arrays() {
    print "demo_arrays: start\n";

    my @items_list = qw(e f a b c d);
    print "demo_arrays: List = @items_list\n";

    print "demo_arrays: Adding an item at the end: push\n";
    push @items_list, "g";
    print "demo_arrays: List = @items_list\n";

    print "demo_arrays: Removing an item at the end: pop\n";
    my $item = pop @items_list;
    print "demo_arrays: List = @items_list\n";

    print "demo_arrays: Removing an item at the start: shift\n";
    $item = shift @items_list;
    print "demo_arrays: List = @items_list\n";

    print "demo_arrays: Adding an item at the start: unshift\n";
    unshift @items_list, $item;
    print "demo_arrays: List = @items_list\n";

    print "demo_arrays: Printing list with a separator: join\n";
    print "demo_arrays: List = " . join( ", ", @items_list ) . "\n";

    print "demo_arrays: Using 'map' to apply a function to each item:\n";
    my @items_list_upper = map { uc $ARG } @items_list;
    print "demo_arrays: List      = @items_list\n";
    print "demo_arrays: List (uc) = @items_list_upper\n";

    print "demo_arrays: Using 'grep' to select items\n";
    my @items_with_c = grep { /c/i } @items_list;
    print "demo_arrays: List     = @items_list\n";
    print "demo_arrays: List (c) = @items_with_c\n";

    print "demo_arrays: Sorting a list with 'sort'\n";
    my @items_list_sorted = sort @items_list;
    print "demo_arrays: List          = @items_list\n";
    print "demo_arrays: List (sorted) = @items_list_sorted\n";

    print "demo_arrays: lexicographical sort vs numerical sort\n";
    my @list = ( "22", "1", "17", "8" );
    print "demo_arrays: unsorted = @list\n";
    my @list_sorted = sort @list;
    print "demo_arrays: lex = @list_sorted\n";
    @list_sorted = sort { $a <=> $b } @list;
    print "demo_arrays: num = @list_sorted\n";

    print "demo_arrays: Array looping, C/C++ style, when needing the index\n";
    for ( my $array_index = 0 ; $array_index <= $#items_list ; $array_index++ )
    {
        print "demo_arrays: array item #$array_index";
        print " = $items_list[$array_index]\n";
    }

    print "demo_arrays: Array looping, automatic foreach\n";
    foreach my $item (@items_list) {
        print "demo_arrays: sarray item = $item\n";
    }

    print "demo_arrays: end\n";
}

sub demo_hashes() {
    print "demo_hashes: start\n";

    my %user_info = (
        id     => 1001,
        name   => "bob",
        active => 1,
    );

    print "demo_hashes: Printing a hash can't use %user_info\n";

    # Sorting keys to make sure it is stable
    for my $k ( sort keys %user_info ) {
        printf "demo_hashes: %8s ==> %8s\n", $k, $user_info{$k};
    }

    # Adding a new field is just that
    $user_info{email} = "bob\@example.com";

    print "demo_hashes: New field added\n";
    for my $k ( sort keys %user_info ) {
        printf "demo_hashes: %8s ==> %8s\n", $k, $user_info{$k};
    }

    print "demo_hashes: Delete a field\n";
    delete $user_info{email};
    for my $k ( sort keys %user_info ) {
        printf "demo_hashes: %8s ==> %8s\n", $k, $user_info{$k};
    }

    print "demo_hashes: Check if a field is present with 'exists'\n";
    if ( exists $user_info{email} ) {
        print "demo_hashes: Field email is still present\n";
    }
    else {
        print "demo_hashes: Field email was deleted.\n";
    }

    print "demo_hashes: end\n";
}

sub demo_refs() {

    # Scalar reference
    my $name     = "Ada";
    my $name_ref = \$name;

    # Array reference
    my @colors     = qw(red green blue);
    my $colors_ref = \@colors;

    # Hash reference
    my %person = (
        age  => 30,
        city => "Paris",
    );
    my $person_ref = \%person;

    # Code reference
    my $greet_ref = sub {
        my ($who) = @_;
        return "Hello, $who!";
    };

    print "demo_refs: Scalar ref: $$name_ref\n";
    print "demo_refs: Array ref: " . join( ", ", @$colors_ref ) . "\n";
    print "demo_refs: Hash ref: age=$person_ref->{age}\n";
    print "demo_refs: Code ref: " . $greet_ref->("world") . "\n";
}

sub demo_flow() {
    print "demo_flow: if elsif else\n";

    # given/when can be useful but many teams prefer if/elsif.
    my @values = ( 3, PI, 4 );

    foreach my $v (@values) {
        print "demo_flow: value is $v\n";
        if    ( $v > PI ) { print "demo_flow: value is larger than PI\n"; }
        elsif ( $v < PI ) { print "demo_flow: value is smaller than PI\n"; }
        else              { print "demo_flow: value is other\n"; }
    }

    print "demo_flow: for and while loops\n";
    for my $i ( 5 .. 8 ) {
        my $parity = $i % 2 == 0 ? 'even' : 'odd';
        print "demo_flow: iteration $i is $parity\n";
    }

    my $i = 0;
    while ( $i < 3 ) {
        print "demo_flow: while valule  = $i\n";
        $i++;
    }

    my %capitals = (
        "Canada" => "Ottawa",
        "USA"    => "Washington D.C.",
        "Mexico" => "Mexico City",
    );

    # Looping through the key/value pairs, not ordered.
    print "demo_flow: Capitals\n";
    for my ( $key, $value ) (%capitals) {
        print "demo_flow: $key : $value\n";
    }
}

sub demo_subs() {
    my $num1   = 3;
    my $num2   = 4;
    my $result = 0;

    print "demo_subs: num1 = $num1\n";
    print "demo_subs: num2 = $num2\n";

    $result = demo_subs_named_args( $num1, $num2 );
    print "demo_subs: demo_subs_named_args  = $result\n";

    $result = 0;
    $result = demo_subs_unamed_args( $num1, $num2 );
    print "demo_subs: demo_subs_unamed_args = $result\n";

    # This will compile but fail at run time.
    # $result = 0;
    # $result = demo_subs_no_args( $num1, $num2 );
    # print "demo_subs: demo_subs_no_args = $result\n";

    print "demo_subs: state function\n";
    demo_subs_state_var();

    print "demo_subs: state function second call\n";
    demo_subs_state_var();
}

sub demo_subs_named_args ( $value1, $value2 ) {
    return $value1 + $value2;
}

sub demo_subs_unamed_args {
    my $sum = $ARG[0] + $ARG[1];
    return $sum;
}

sub demo_subs_no_args () {

    # Empty parenthesis to make sure no arguments will
    # be used.
    my $sum = $ARG[0] + $ARG[1];
    return $sum;
}

sub demo_subs_state_var () {

    # State variables
    # perldoc -f state
    state $count = 0;

    print "demo_subs: demo_subs_state_var before iteration = $count\n";
    $count++;
    print "demo_subs: demo_subs_state_var after iteration = $count\n";
}

sub demo_exec() {

    # Using tainting mechanism needs some environment cleanup
    # before running commands.
    # https://stackoverflow.com/questions/4552197/
    # insecure-envenv-while-running-with-t-switch#4552306
    delete @ENV{ 'PATH', 'IFS', 'CDPATH', 'ENV', 'BASH_ENV' };

    print("demo_exec: executing an external command.\n");
    my @combined_output_lines = `ls -l /tmp 2>&1`;

    print("demo_exec: command output:\n");
    foreach my $line (@combined_output_lines) {

        # Removing the trailing newline character with chomp.
        chomp $line;
        print("demo_exec: $line\n");
    }
}

sub demo_fileinfo() {
    my @path_list = qw(/tmp /etc/os-release);

    foreach my $path (@path_list) {
        print "demo_fileinfo: Checking path: $path\n";

        # This is not a complete list, see "perldoc perlfunc" for more.
        my %results = (
            "-r is readable         " => -r $path,
            "-w is writable         " => -w $path,
            "-e does exist          " => -e $path,
            "-z is empty            " => -z $path,

            # "Size: " in stat command
            "-s size in bytes       " => -s $path,
            "-f is a regular file   " => -f $path,
            "-d is a directory      " => -d $path,

            # Text/Binary = guesstimation
            "-T is a text file      " => -T $path,
            "-B is a binary file    " => -B $path,

            # "Change: " in stat command is not the same as Modify
            "-C last change in days " => -C $path,
        );

        foreach my $k ( sort keys %results ) {
            print "demo_fileinfo: $k : " . $results{$k} . "\n";
        }
    }
}

sub demo_stdin() {
    print "demo_stdin: reading stdin line by line.\n";
    print "demo_stdin: CTRL + D to stop.\n";

    # STDIN, STDOUT and STDERR are already open at program start.
    foreach (<STDIN>) {

        # trimming the line (both ends)
        $ARG =~ s/^\s+|\s+$//g;
        print "demo_stdin: line read = $ARG\n";
        print STDERR "demo_stdin: stderr line read = $ARG\n";
    }
}

sub demo_data() {
    print "demo_data: reading the DATA section ";
    print "at the end of the file\n";

    # DATA is a file handle open at the start of the program.
    foreach (<DATA>) {

        # chomp-ing for a better print experience
        chomp $ARG;
        print "demo_data: data line = $ARG\n";
    }
}

sub demo_read_write_files() {
    delete @ENV{ 'PATH', 'IFS', 'CDPATH', 'ENV', 'BASH_ENV' };
    my $temp_path = `mktemp`;

    if ( $OS_ERROR != 0 ) {
        print "demo_read_write_files: creation failed: $OS_ERROR\n";
        return;
    }

    # Helping with tainting: see perldoc perlsec
    if ( $temp_path =~ /^(\S+)$/ ) {
        $temp_path = $1;
    }

    print "demo_read_write_files: temp path = $temp_path\n";

    print "demo_read_write_files: open file\n";

    # use '>>' to append to a file
    if ( open( my $write_file_handle, '>', $temp_path ) ) {

        print $write_file_handle "First line in temp file\n";
        print $write_file_handle "Second line in temp file\n";
        print $write_file_handle "Third line in temp file\n";

        print "demo_read_write_files: closing file\n";
        close($write_file_handle);
        print "demo_read_write_files: file closed\n";

        if ( open( my $read_file_handle, '<', $temp_path ) ) {

            while ( defined( my $line = <$read_file_handle> ) ) {
                $line =~ s/^\s+//;
                $line =~ s/\s+$//;
                print "demo_read_write_files: reading line = $line\n";
            }

            print "demo_read_write_files: closing file\n";
            close($write_file_handle);
            print "demo_read_write_files: file closed\n";
        }
        else {
            print
              "demo_read_write_files: failure to open for reading $OS_ERROR\n";
        }
    }
    else {
        print "demo_read_write_files: failure to open for writing $OS_ERROR\n";
    }

    print "demo_read_write_files: delete temp path = $temp_path\n";
    unlink $temp_path;
    print "demo_read_write_files: delete done\n";
}

sub demo_bin_mode() {
    print "demo_bin_mode: creating a small GIF in /tmp/output.gif\n";

    if ( open( my $output_fh, ">", "/tmp/output.gif" ) ) {

        # binmode is mainly used for non-unix systems
        binmode($output_fh);

        # creating a 1 X 1 pixel GIF image
        print $output_fh "\107\111\106\070\071\141";
        print $output_fh "\001\000\001\000";
        print $output_fh "\200\000\000";
        print $output_fh "\000\000\000";
        print $output_fh "\377\377\377";
        print $output_fh "\054\000\000\000\000\001\000\001\000\000";
        print $output_fh "\002\002\104\001\000";
        print $output_fh "\073";

        close($output_fh);
    }
    else {
        print "demo_bin_mode: failure to open in write mode\n";
    }
}

sub demo_json () {
    my %user_info = (
        name   => "bob",
        age    => undef,
        fruits => [ "apple", "banana" ]
    );

    my $user_info_text = encode_json { %user_info };

    print "demo_json: user info\n";
    print "demo_json: as hash = ";
    print Dumper %user_info;
    print "demo_json: as JSON string = $user_info_text\n";

    my $ref_decoded =
      decode_json '{"age":null,"name":"bob","fruits":["apple","banana"]}';

    print "demo_json: decoded (dumper) = ";

    print Dumper $ref_decoded;
}

main();

__END__
This it the first line of the DATA section.
This is the second line.
Another line.
The DATA section appears at the end
of the file after the keyword.
