#!/usr/bin/perl -W -t -T

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

sub process_arguments() {
    my $arg_help_mode = 0;

    my $processed_cmd_line_result = GetOptions( "help" => \$arg_help_mode, );

    if ($arg_help_mode) {
        print_usage();
        exit(0);
    }
}

sub print_usage() {
    print("Magic 8 Ball (https://en.wikipedia.org/wiki/Magic_8-Ball)\n");
    print(
        "no options needed, will print a magic answer to a yes/no question\n");
    print("--help : Print this help message\n");
}

sub main() {
    process_arguments();

    my @answers = (
        "It is certain.",
        "It is decidedly so.",
        "Without a doubt.",
        "Yes - definitely.",
        "You may rely on it.",
        "As I see it, yes.",
        "Most likely.",
        "Outlook good.",
        "Yes.",
        "Signs point to yes.",
        "Reply hazy, try again.",
        "Ask again later.",
        "Better not tell you now.",
        "Cannot predict now.",
        "Concentrate and ask again.",
        "Don't count on it.",
        "My reply is no.",
        "My sources say no.",
        "Outlook not so good.",
        "Very doubtful."
    );

    my $selected_answer = int( rand($#answers) + 1 );

    print( "MAGIC 8-BALL SAYS: " . $answers[$selected_answer] . "\n" );
}

main();

exit(0);
