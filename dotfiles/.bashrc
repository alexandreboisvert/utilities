# Adding the following lines to ~/.bashrc

# Better autocomplete, similar to the zsh autocomplete
bind 'TAB:menu-complete'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# https://www.mfitzp.com/article/customize-directory-colors/
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;33:*.jpeg=01;33:*.mjpg=01;33:*.mjpeg=01;33:*.gif=01;33:*.bmp=01;33:*.pbm=01;33:*.pgm=01;33:*.ppm=01;33:*.tga=01;33:*.xbm=01;33:*.xpm=01;33:*.tif=01;33:*.tiff=01;33:*.png=01;33:*.svg=01;33:*.svgz=01;33:*.mng=01;33:*.pcx=01;33:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*.pdf=01;96';
export LS_COLORS

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# bigger history
HISTSIZE=100000
HISTFILESIZE=2000000

# GOLANG paths
export PATH=$PATH:/usr/local/go/bin
export GOPATH="${HOME}/go"

# tree chars
export TREE_CHARSET="ASCII"

# home page for w3m
export WWW_HOME='https://duckduckgo.com/lite'

# dotnet settings
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT="${HOME}/.dotnet"
export PATH="${PATH}:${DOTNET_ROOT}"

# bash parameter completion for the dotnet CLI
# https://docs.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete
_dotnet_bash_complete()
{
  local word=${COMP_WORDS[COMP_CWORD]}
  local completions
  completions="$(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)"
  if [[ $? -ne 0 ]]
  then
    completions=""
  fi

  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}
complete -f -F _dotnet_bash_complete dotnet

# tell gpg to use the tty to get a password
GPG_TTY="$(tty)"
export GPG_TTY

# Disable Accidental Terminal Suspends
# CTRL-S will freeze the terminal until CTRL-Q
# Disable CTRL-S, we don't need this with modern terminal emulators
stty stop undef
