#!/usr/bin/perl -W -t -T

# Perl Skeleton file.

# useful commands:
# validation check
# perl -c -t -W skeleton.pl
# formatting (apt install perltidy)
# perltidy -b skeleton.pl

# part of perlstyle: http://perldoc.perl.org/perlstyle.html
use strict;
use warnings;

use sigtrap;
use diagnostics;

# apt install libmodern-perl-perl
# use Modern::Perl '2017';

# use Data::Dumper;

# Code goes here

my $usage = qq(
Usage for $0:
  $0 help    : display this help and exit
  $0 version : display the version and exit
);

print("${usage}\n");
