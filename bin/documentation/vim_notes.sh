#!/usr/bin/env bash

cat << EOF

# AUTOCOMPLETE
CTRL + n

# SPELLCHECK
# enable spellcheck (vim-spell-en package required)
:set spell spelllang=en_us
# move to the misspelled word and type
z=

# WHITE SPACE AND TABS
# Show white spaces and tabs in vim:
# from: https://stackoverflow.com/questions/1675688
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
:set list

EOF
