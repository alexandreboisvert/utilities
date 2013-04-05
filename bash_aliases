# This is the template file ~/.bash_aliases

# Add to (or uncomment) the file ~/.bashrc
# Aliases file to not overfill the ~/.bashrc
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# I create UPPERCASE aliases to avoid any confusion with the Linux 
# built-in or native commands.

# File space available under different devices on the system.
alias AVAIL='df --human-readable | grep --ignore-case --invert-match none'

# Verbose and asking for confirmation (avoid some big bad mistakes).
alias CP='cp --interactive --verbose'
alias MV='mv --interactive --verbose'
alias RM='rm --interactive --verbose'

# Disk space used in the current directory with the largest items at
# the bottom.
alias SIZE='du --summarize --human-readable --total * | sort --human-numeric-sort'

# Mount an ISO file as a directory instead of having a CD.
# ISOMOUNT input_file.iso /destination/directory/
alias ISOMOUNT='sudo mount -o loop'

# File listing
# -l: long format
# --classify: adding a visual hint for the file type
# -t --reverse: reverse chronological order (most recent at the bottom)
# --human-readable: Friendly file size (KB, MB, etc.)
# --color=auto: coulors if available
# --time-style=long-iso: ISO8601 time format
# --all: all the files, including hidden files
alias LLL='ls -l --all --classify -t --reverse --human-readable --color=auto --time-style=long-iso'
alias LL='ls -l --classify -t --reverse --human-readable --color=auto --time-style=long-iso'

# Shorcut to the nano text editor with some common options
alias NANO='nano --smarthome --smooth --const --autoindent --mouse --nowrap'

# Fast ping (only 5 pings, then exit)
alias PING5='ping -c 5'

# A more detailed list of processes
alias PSLIST='ps -e -o time,pid,user,state,command'

# Easy ROT13 obfuscation (this is not encryption!)
alias ROT13='tr '\''A-Za-z'\'' '\''N-ZA-Mn-za-m'\'''

# Small web server. The current directory is available at 
# http://127.0.0.1:8080
# This is not for production.
alias SERVER='python -m SimpleHTTPServer'

# Common TAR commands
# Extract the file
# TAR_EXTRACT file.tar
alias TAR_EXTRACT='tar -xf'
# List the contents for the file
# TAR_LIST file.tar
alias TAR_LIST='tar -tf'

# End of the template file ~/.bash_aliases
