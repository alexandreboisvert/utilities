#!/usr/bin/env bash

cat << EOF

# BASH notes

######################################################################
# Check out this:
https://github.com/dylanaraps/pure-bash-bible
https://github.com/dylanaraps/pure-sh-bible

######################################################################
# diff on 2 commands outputs
diff <(tail -n5 file1.txt) <(tail -n5 file2.txt)

######################################################################
# simple shell expansion
# will print numbers with leading 0
for i in {01..05}
do
  echo "\${i}"
done

######################################################################
### wrong
#count=1
#echo "count before \$count"
#cat /tmp/foo.txt | while read -r line ; do
#  ((count++))
#  echo "\$count \$line"
#done
#echo "count after \$count"

### ok
#count=1
#echo "count before \$count"
#while read -r line ; do
#  ((count++))
#  echo "\$count \$line"
#done < /tmp/foo.txt
#echo "count after \$count"

# it does not work because "|" creates a subshell

######################################################################
# using [[ ]] instead of [ ]
# see http://mywiki.wooledge.org/BashGuide/SpecialCharacters

######################################################################
# string splitting
input_string="abc def ghi jkl mno pqr"
echo "\${input_string}"
echo "first and last token"
echo "\${input_string%% *}"
echo "\${input_string##* }"
# greedy %% and ##
# non greedy % and #

EOF
