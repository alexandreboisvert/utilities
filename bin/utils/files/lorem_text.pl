#!/usr/bin/perl -W -t -T

# Generate filler text: the infamous "Lorem ipsum"

# useful commands:
# validation check
# perl -c -t -W template_boilerplate.pl
# formatting
# perltidy -b template_boilerplate.pl

# part of perlstyle: http://perldoc.perl.org/perlstyle.html
use strict;
use warnings;

# Arguments parsing
use Getopt::Long;

sub print_help() {
    print "Lorem ipsum text generator\n"
      . "Options:\n"
      . "--help, -h           : Show this help and exit.\n"
      . "--length=000, -l 000 : How many paragraphs of Lorem Ipsum text required.\n";
}

sub main() {

    my $arg_text_length = 0;
    my $arg_help        = 0;
    my $lorem_paragraph =
"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eleifend ante vitae turpis venenatis, eu placerat nunc tincidunt. Nam sit amet augue malesuada, luctus nisi nec, pharetra erat. Suspendisse vel velit id nibh scelerisque euismod. Nullam sollicitudin, mi nec vehicula sodales, arcu quam rhoncus erat, ut ultricies urna quam sed nunc. Aenean ornare pharetra sollicitudin. Nulla vestibulum nisi ac malesuada commodo. Sed auctor augue sed tortor tempus aliquam. Sed fringilla velit sed convallis malesuada. Morbi ligula nibh, tempor at erat quis, pulvinar tristique justo. Nam nec efficitur tortor.";

    my $getoptresult = GetOptions(
        "help"     => \$arg_help,
        "length=i" => \$arg_text_length,
    ) or die("Error in command line arguments\n");

    if ($arg_help) {
        print_help();
        exit(0);
    }

    if ( $getoptresult && ( $arg_text_length > 0 ) ) {
        for ( my $i = 0 ; $i < $arg_text_length ; $i++ ) {
            print "$lorem_paragraph\n";
        }
    }
    else {
        print "Invalid arguments\n";
        print_help();
        exit(1);
    }
}

main();

exit 0;
