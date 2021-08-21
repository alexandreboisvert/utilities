#!/usr/bin/env bash

cat <<EOF

# html2text conversion

curl 'http://example.com/page.html' | w3m -dump -T text/html > page.txt

# Keys

SHIFT + h : show help

# Navigation

j,k       : vim scroll
g         : top
SHIFT + g : bottom
TAB       : next link
SHIFT + s : save page (text format)
q         : quit

# URLs

a         : save URL
u         : URL preview
SHIFT + b : go back

# Search

/ : forward search
? : backward search

# Settings

o : open settings, go down to OK button to save

EOF


