#!/usr/bin/env bash

cat <<EOF

sed -E for better regex without having to cancel characters like "(" and ")"

echo 'the price is 10.00$ for 3 items' | sed -E 's/the price is ([0-9]+\.[0-9]+)\$ for ([0-9]+) items/\2 i for \1 bucks/'
3 i for 10.00 bucks


tldr
# sed
> See also: awk, ed.
> More information: <https://www.gnu.org/software/sed/manual/sed.html>.

- Replace all apple (basic regex) occurrences with mango (basic regex) in all input lines and print the result to stdout:

{{command}} | sed 's/apple/mango/g'

- Execute a specific script [f]ile and print the result to stdout:

{{command}} | sed -f {{path/to/script.sed}}

- Print just a first line to stdout:

{{command}} | sed -n '1p'

- Replace all apple (extended regex) occurrences with APPLE (extended regex) in all input lines and print the result to stdout:

{{command}} | sed -E 's/(apple)/\U\1/g'

- Print just a first line to stdout:

{{command}} | sed -n '1p'

- Replace all apple (basic regex) occurrences with mango (basic regex) in a file and save a backup of the original to file.bak:

sed -i bak 's/apple/mango/g' {{path/to/file}}

EOF
