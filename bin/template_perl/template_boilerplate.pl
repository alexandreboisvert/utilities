#!/usr/bin/perl -W -t -T

# this is bad code, it is only a template

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

sub basic_vars() {
    print "=== BASIC VARS ===\n";
    print "this is a script\n";
    my $scalar_var1 = "string var";
    my $scalar_var2 = 3.14159;
    my $scalar_var3 = 2 * $scalar_var2;
    print "value of Pi = $scalar_var2\n";
    print "value of Tau = $scalar_var3\n";
    print "value of var1 = $scalar_var1\n";
    my $name = "Bobby Tables";
    print "the name is $name\n";
    print 'the name is not $name\n';
    print "\n";
    my $name_suffix = " Jr";
    my $full_name   = $name . $name_suffix;
    print "Full name = $full_name\n";
    my $original_text = "This is a sentence. Here is another one.";
    print "Original var = $original_text\n";
    my $original_text_length = length($original_text);
    print "Length = $original_text_length\n";
    my $uc_text = uc($original_text);
    my $lc_text = lc($original_text);
    print "Uppercase text = $uc_text\n";
    print "Lowercase text = $lc_text\n";
}

sub flow_control() {
    print "=== FLOW CONTROL ===\n";
    my $control_if = 1;
    if ( $control_if >= 1 and "bob" eq "bob" ) {
        print "greater or equal to 1\n";
    }
    else {
        print "not greater or equal to 1\n";
    }
    my $counter = 0;
    while ( $counter < 5 ) {
        print "while loop $counter\n";
        $counter++;
    }
    for ( $counter = 0 ; $counter < 5 ; $counter = $counter + 1 ) {
        print "for loop $counter\n";
    }
    $counter = 0;
    while ( $counter < 5 ) {
        print "while loop abort at 3: $counter\n";
        last if ( $counter == 3 );
        $counter++;
    }
}

sub basic_arrays() {
    print "=== BASIC ARRAYS ===\n";
    my @array1 = ( "one", "two", "three", "four" );
    print "array1 = @array1\n";
    print "array1[0] = $array1[0]\n";
    print "last index of array1: $#array1\n";
    my $array_index = 0;
    for ( $array_index = 0 ; $array_index <= $#array1 ; $array_index++ ) {
        print "array item = $array1[$array_index]\n";
    }

    # alternative syntax for array definition
    my @array2 = qw(one two three four);
    print "array2 = @array2\n";
    foreach my $array_item (@array1) {
        print "array item: $array_item\n";
    }

 # careful: processing an array item is done by reference, changes are permament
}

sub command_line_arguments() {
    print "=== COMMAND LINE ARGUMENTS ===\n";
    print "Processing command line arguments\n";

    # default values:
    my $config_file_name   = "template_boilerplate.json";
    my $verbose_mode       = 0;
    my $argument_int_value = 0;
    my $getoptresult       = GetOptions(
        "configfile=s" => \$config_file_name,
        "verbose"      => \$verbose_mode,
        "number=i"     => \$argument_int_value,
    );

    # or die("Error in command line arguments\n");
    if ($getoptresult) {
        print "Getopt used properly\n";
    }
    else {
        print "Getopt failed\n";
    }

    #print "getopt result: $getoptresult\n";
    print "config_file_name: $config_file_name\n";
    print "verbose_mode: $verbose_mode\n";
    print "argument number: $argument_int_value\n";
}

sub stdin_reading() {

    # reading stdin with scalars ($) and arrays (@)
    print "reading one line from STDIN:\n";
    my $current_line = <STDIN>;
    print "data read from STDIN:\n";
    print "$current_line\n";

    print "reading multiple lines from STDIN (ends with EOF or CTRL + D):\n";
    my @current_lines = <STDIN>;
    print "data read from STDIN:\n";
    print "current_lines:\n@current_lines\n";
    foreach my $line_read (@current_lines) {

        # no trim function in perl, using a regex (like sed)
        $line_read =~ s/^\s+|\s+$//g;
        print "line: $line_read\n";
    }
}

sub split_strings() {
    print "=== SPLIT STRINGS ===\n";
    my $s1 = "The quick brown fox jumps over the lazy dog.";
    my $s2 = "Lorem ipsum, dir solor amet.";
    print "the strings:\n";
    print "s1: $s1\n";
    print "s2: $s2\n";
    print "split on null '' string = one char at the time:\n";

    # the split argument is in fact a regex //
    my @items = split( //, $s1 );
    foreach my $item (@items) {
        print "item: $item\n";
    }
    print "split on space ' ' string = one word at the time:\n";
    @items = split( / /, $s1 );
    foreach my $item (@items) {
        print "item: $item\n";
    }
    print "split on comma ',' string = half the sentence:\n";
    @items = split( /,/, $s2 );
    foreach my $item (@items) {
        print "item: $item\n";
    }
}

sub join_strings() {
    print "=== JOIN STRINGS ===\n";
    print "a list of numbers:\n";
    my $new_list = join( ",", ( 1 .. 10 ) );
    print "$new_list\n";
    my @array1 = split( / /, "The quick brown fox jumps over the lazy dog" );
    print "list of words\n";
    $new_list = join( "*", @array1 );
    print "$new_list\n";
}

sub sort_arrays() {
    print "=== SORT ARRAYS ===\n";
    print "input array:\n";
    my @array1 = ( 22, 1, 17, 8 );
    print "@array1\n";
    my @sorted_array1 = sort @array1;
    print "sorted array (LEXICOGRAPHICAL):\n";
    print "@sorted_array1\n";
    @sorted_array1 = sort { $a <=> $b; } @array1;
    print "sorted array (NUMERICAL):\n";
    print "@sorted_array1\n";
    print "reversed array (LEXICOGRAPHICAL):\n";
    @sorted_array1 = reverse @array1;
    print "@sorted_array1\n";
    print "reversed array (NUMERICAL):\n";

    # reverse does not support <=>
    @sorted_array1 = reverse sort { $a <=> $b; } @array1;
    print "@sorted_array1\n";
}

sub reading_files() {
    print "=== READING FILES ===\n";
    my $file_name = "./template_boilerplate.json";

    print "reading only one line at a time\n";
    if ( open( INPUT_FILEH, $file_name ) ) {
        print "Opened the file $file_name successfully\n";
        my $current_line = "";
        while ( defined( $a = <INPUT_FILEH> ) ) {

            #$a =~ s/^\s+|\s+$//g ;
            # chomp removes the newline char, but it is not trim
            chomp $a;
            print "line read: $a\n";
        }
        close(INPUT_FILEH);
    }
    else {
        print "Failed to open the file $file_name\n";
    }

    print "read all the lines in bulk (watch the memory)\n";
    my @all_lines;
    if ( open( INPUT_FILEH, $file_name ) ) {
        @all_lines = <INPUT_FILEH>;
        close(INPUT_FILEH);
    }
    else {
        print "Failed to open the file $file_name\n";
    }
    foreach my $current_line (@all_lines) {

        #$current_line =~ s/^\s+|\s+$//g ;
        chomp $current_line;
        print "line read: $current_line\n";
    }
}

sub writing_files() {
    print "=== WRITING FILES ===\n";
    my $output_filename = "./outfile1.txt";
    my @data_list       = qw(5 1 4 2 8 0 5 8 1 1);

    print "overwrite\n";
    if ( open( OUTPUT_FH, ">$output_filename" ) ) {
        print OUTPUT_FH "@data_list\n";
        close(OUTPUT_FH);
    }
    else {
        print "Failed to open the file $output_filename\n";
    }
    print "append\n";
    if ( open( OUTPUT_FH, ">>$output_filename" ) ) {
        print OUTPUT_FH "append\n";
        close(OUTPUT_FH);
    }
    else {
        print "Failed to open the file $output_filename\n";
    }
}

sub stdin_stdout_stderr() {
    print "=== STDIN STDOUT STDERR ===\n";
    print STDOUT "this is stdout\n";
    print STDERR "this is stderr\n";
}

sub binary_mode() {

    # mostly for non-unix systems.
    print "=== BINARY FILES ===\n";
    my $output_filename = "img.gif";
    if ( open( OUTPUT_FH, ">$output_filename" ) ) {
        binmode(OUTPUT_FH);
        print OUTPUT_FH "GIF87a\056\001\045\015\000";
        close(OUTPUT_FH);
    }
    else {
        print "Failed to open the file $output_filename\n";
    }
}

sub file_information() {
    print "=== FILE INFORMATION ===\n";
    my $file_name = "./template_boilerplate.json";
    print "Check the file: $file_name\n";

    # there a more file operators, see "perldoc perlfunc"
    my @checks = (
        "-r is readable",
        "-w is writable",
        "-e does exist",
        "-z is empty",
        "-s size in bytes",
        "-f is a regular file",
        "-d is a directory",
        "-T is a text file",
        "-B is a binary file",
        "-M age in days",
    );
    my @results = (
        -r $file_name,
        -w $file_name,
        -e $file_name,
        -z $file_name,
        -s $file_name,
        -f $file_name,
        -d $file_name,
        -T $file_name,
        -B $file_name,
        -M $file_name,
    );
    for my $array_index ( 0 .. $#results ) {
        print "Check: $checks[$array_index] = $results[$array_index].\n";
    }
}

sub pattern_matching() {
    print "=== PATTERN MATCHING ===\n";
    my @input_list       = qw(foo bar lorem ipsum);
    my $pattern_to_match = "m";
    print "Inputs: @input_list\n";
    print "Pattern: $pattern_to_match\n";
    for my $current_item (@input_list) {
        if ( "$current_item" =~ /$pattern_to_match/ ) {
            print "Matched: $current_item\n";
        }
    }
    print "Substitution in place in array\n";
    for my $current_item (@input_list) {
        if ( $current_item =~ s/sum/SUM/ ) {
            print "Matched: $current_item\n";
        }
    }
    print "grep\n";
    print "Inputs: @input_list\n";
    my @o_words = grep /o/, @input_list;
    print "o words: @o_words\n";
    print "long words:\n";
    my @l_words = grep length($_) > 3, @input_list;
    print "long words: @l_words\n";
}

sub basic_hashes() {
    print "=== HASHES ===\n";
    my %Movies = (
        'The Shining' => 'Stanley Kubrick',
        'The Goonies' => 'Steven Spieldberg',
        'Avatar'      => 'James Cameron'
    );
    if ( exists $Movies{'Avatar'} ) {
        print "One Director = $Movies{'Avatar'}\n";
    }
    foreach my $movie_title ( keys %Movies ) {
        print "Movie = $movie_title, Director = $Movies{$movie_title}\n";
    }
}

#basic_vars();

#flow_control();

#basic_arrays();

#command_line_arguments();

#stdin_reading();

#split_strings();

#join_strings();

#sort_arrays();

#reading_files();

#writing_files();

#stdin_stdout_stderr();

#binary_mode();

#file_information();

#pattern_matching();

#basic_hashes();

# functions don't have named arguments???
sub mini1 {
    print "This is mini1\n";
    print "Arguments list:\n";
    for my $argument (@_) {
        print "Argument: $argument\n";
    }
    print("End of arguments list\n");
}

#mini1("a", "b");

# if we do not want arguments: ()
sub mini2() {
    print "mini2 does not accept arguments\n";
}

#mini2();

# returning something
sub mini3 {
    print "mini3 will return something\n";
    my $running_total = 0;
    for my $argument (@_) {
        $running_total = $running_total + $argument;
    }
    print "mini3 returns: $running_total\n";
    return $running_total;
}

#print "result of mini3:", mini3(1,2,3), "\n";

exit 0;
