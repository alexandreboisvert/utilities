#!/usr/bin/env bash

cat << EOF

# BASH notes

#####################################################################3
# Check out this:
https://github.com/dylanaraps/pure-bash-bible
https://github.com/dylanaraps/pure-sh-bible

#####################################################################3
# diff on 2 commands outputs
diff <(tail -n5 file1.txt) <(tail -n5 file2.txt)

#####################################################################3
# simple shell expansion
# will print numbers with leading 0
for i in {01..05}
do
  echo "\${i}"
done

#####################################################################3
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

EOF
