#!/usr/bin/env bash

cat << EOF

# AWK notes

# grep-like use
$ awk '/floppy/{print \$0} /wheel/{print \$0}' /etc/group

# using BEGIN END blocks example
# get the sum of the numbers
$ cat list_of_numbers.txt
99.98
0.01
$ awk 'BEGIN{sum = 0;}{sum += \$1}END{print "sum = ", sum}' list_of_numbers.txt
sum = 99.99

# using system() for external programs
# part of the update script
$ docker images -a | awk '{if (\$1 != "REPOSITORY" && \$2 != "<none>") system("docker pull " \$1 ":" \$2)}'

# change the field separator
$ awk -F ':' '{print \$1}' /etc/passwd
root
bin
...

# last field = NF
$ awk -F '/' '/^\//{print \$NF}' /etc/shells
sh
bash
git-shell
...

# some built-in functions
# length of the line
$ awk 'length(\$0) > 10' /etc/shells
/usr/bin/git-shell
...

# getting the index of a match
$ awk 'match(\$0, /us/){print \$0 " has a us at position " RSTART}' /etc/shells
/usr/bin/git-shell has a us at position 2

# conditionals
$ ps -ef | awk '{if(\$NF == "/bin/bash") print \$0}'
alex        1502    1497  0 16:34 pts/0    00:00:00 /bin/bash
alex        3457    3452  0 16:44 pts/12   00:00:00 /bin/bash
alex       15839   15834  0 18:14 pts/14   00:00:00 /bin/bash
...

# loops
$ awk 'BEGIN{for(i=0;i<10;i++) print i, i*i}'
0 0
1 1
2 4
3 9
4 16
5 25
6 36
7 49
8 64
9 81

# only print lines between 10 and 20
$ ps -ef | awk 'NR==10, NR==20 {print NR, \$0}'

# match something in the first field and second field
# and count the rows
$ cmd_or_script | awk 'BEGIN{r = 0} \$1 == 1 && \$2 ~ /^regex\$/ { r += 1} END{print r}'

EOF
