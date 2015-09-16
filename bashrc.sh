# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export EDITOR=/usr/bin/vim

# ignore commands with leading spaces, and duplicate commands
export HISTCONTROL=ignoreboth
# big history and file size
export HISTSIZE=10000
export HISTFILESIZE=20000
# append to history, don't overwrite it
shopt -s histappend
# append to history after each command finishes
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# Define some colors:
yellow='\e[0;33m'
green='\e[0;32m'
light_red='\e[0;91m'
light_blue='\e[0;94m'
light_cyan='\e[0;96m'
light_magenta='\e[0;95m'
NC='\e[0m'  # No color
alias datemtv="env TZ=America/Los_Angeles date"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  HILIT=${light_red}   # remote machine: prompt will be partly light_red
else
  HILIT=${light_cyan}  # local machine: prompt will be partly light_cyan
fi

# Display 'whoami@hostname' before a standard prompt.
PS1="\n${yellow}$(echo -n '[ `datemtv` ]')\n\
${HILIT}$(echo -n '`whoami`@`hostname -s`')\[\$(tput sgr0)\]\n\
${light_blue}\${PWD}${NC}\n\$ "
export PS1

# Enable color support in man pages
# https://wiki.archlinux.org/index.php/Man_page#Colored_man_pages
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

# ============================================================================
# Functions from https://github.com/cowboy/dotfiles
# ============================================================================

# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function get_os() {
  for os in osx ubuntu; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

# ============================================================================
# Functions from http://natelandau.com/my-mac-osx-bash_profile/
# ============================================================================

# Move a file to the MacOS trash
if is_osx; then
  trash() { command mv "$@" ~/.Trash ; }
fi

# qfind:    Quickly search for file
alias qfind="find . -name "
# ff:       Find file under the current directory
ff () { /usr/bin/find . -name "$@" ; }
# ffs:      Find file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; }
# ffe:      Find file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }


# extract:  Extract most know archives with one command
# Usage: extract <file>
# ---------------------------------------------------------
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1        ;;
      *.tar.gz)    tar xzf $1        ;;
      *.bz2)       bunzip2 $1        ;;
      *.dmg)       hdiutil mount $1  ;;
      *.rar)       unrar e $1        ;;
      *.gz)        gunzip $1         ;;
      *.tar)       tar xf $1         ;;
      *.tbz2)      tar xjf $1        ;;
      *.tgz)       tar xzf $1        ;;
      *.zip)       unzip $1          ;;
      *.ZIP)       unzip $1          ;;
      *.Z)         uncompress $1     ;;
      *.7z)        7z x $1           ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ============================================================================
# Functions from https://github.com/mathiasbynens/dotfiles
# ============================================================================

# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}";
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead of #
  # `application/octet-stream`, and serve everything as UTF-8 (although not
  # technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Simple calculator
function calc() {
  local result="";
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
        -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
        -e 's/0*$//;s/\.$//';  # remove trailing zeros
  else
    printf "$result";
  fi;
  printf "\n";
}

# Create a data URL from a file
function dataurl() {
  local mimeType=$(file -b --mime-type "$1");
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8";
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# ============================================================================
# Etc.
# ============================================================================
# Print current timestamp just before command is executed.
# See bash-preexec.sh. Credit to https://github.com/rcaloras/bash-preexec .
preexec() { printf "${green}[ `datemtv` ]${NC}\n"; }

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/src/dotfiles/bash-preexec.sh ]; then
  . ~/src/dotfiles/bash-preexec.sh
fi
