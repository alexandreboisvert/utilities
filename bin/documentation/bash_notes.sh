#!/usr/bin/env bash

cat << EOF

# BASH notes

# Check out this:
https://github.com/dylanaraps/pure-bash-bible
https://github.com/dylanaraps/pure-sh-bible

# diff on 2 commands outputs
diff <(tail -n5 file1.txt) <(tail -n5 file2.txt)

# simple shell expansion
# will print numbers with leading 0
for i in {01..05}
do
  echo "\${i}"
done

EOF
