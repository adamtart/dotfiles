# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ignore commands with leading spaces, and duplicate commands
export HISTCONTROL=ignoreboth
# big history and file size
export HISTSIZE=10000
export HISTFILESIZE=20000
# append to history, don't overwrite it
shopt -s histappend
# append to history after each command finishes
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# Define some colors:
yellow='\e[0;33m'
light_red='\e[0;91m'
light_blue='\e[0;94m'
light_cyan='\e[0;96m'
NC='\e[0m'  # No color
alias datemtv="env TZ=America/Los_Angeles date"

if [[ "${DISPLAY%%:0*}" != "" ]]; then
  HILIT=${light_red}   # remote machine: prompt will be partly light_red
else
  HILIT=${light_cyan}  # local machine: prompt will be partly light_cyan
fi

# Display 'whoami@hostname' before a standard prompt.
PS1="\n${yellow}$(echo -n '[ `datemtv` ]')\n\
${HILIT}$(echo -n '`whoami`@`hostname -s`')\[\$(tput sgr0)\]\n\
${light_blue}\${PWD}${NC}\n\$ "
export PS1


# Enable color support of some common commands
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)"
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Enable color support in man pages
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

# Move a file to the MacOS trash
trash() { command mv "$@" ~/.Trash ; }

# qfind:    Quickly search for file
alias qfind="find . -name "
# ff:       Find file under the current directory
ff () { /usr/bin/find . -name "$@" ; }
# ffs:      Find file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; }
# ffe:      Find file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }


# extract:  Extract most know archives with one command
# ---------------------------------------------------------
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
