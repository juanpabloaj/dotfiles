# Get the aliases and functions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Define a few Colours
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color
#########

# MAKE MAN PAGES PRETTY
#######################################################

export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'        # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode
export LESS_TERMCAP_so=$'\E[30;45m'          # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'       # begin underline

############################## ##################################
# ##### PROMPT SECTION ##### ####################################
############################## ##################################

# color_name='\[\033[ color_code m\]

rgb_restore='\[\033[00m\]'
rgb_black='\[\033[00;30m\]'
rgb_firebrick='\[\033[00;31m\]'
rgb_red='\[\033[01;31m\]'
rgb_forest='\[\033[00;32m\]'
rgb_green='\[\033[01;32m\]'
rgb_brown='\[\033[00;33m\]'
rgb_yellow='\[\033[01;33m\]'
rgb_navy='\[\033[00;34m\]'
rgb_blue='\[\033[01;34m\]'
rgb_purple='\[\033[00;35m\]'
rgb_magenta='\[\033[01;35m\]'
rgb_cadet='\[\033[00;36m\]'
rgb_cyan='\[\033[01;36m\]'
rgb_gray='\[\033[00;37m\]'
rgb_white='\[\033[01;37m\]'
rgb_host='${rgb_cyan}'
rgb_std='${rgb_white}'

if [ `id -u` -eq 0 ]
then
 rgb_usr='${rgb_red}'
else
 rgb_usr='${rgb_green}'
fi

[ -n "$PS1" ] && PS1="${rgb_usr}`whoami`${rgb_host}@\h: \W ${rgb_usr}\\\$${rgb_restore} "

unset   rgb_restore   \
 rgb_black     \
 rgb_firebrick \
 rgb_host      \
 rgb_red       \
 rgb_forest    \
 rgb_green     \
 rgb_brown     \
 rgb_yellow    \
 rgb_navy      \
 rgb_blue      \
 rgb_purple    \
 rgb_magenta   \
 rgb_cadet     \
 rgb_cyan      \
 rgb_gray      \
 rgb_white     \
 rgb_std       \
 rgb_usr

if [ -d $HOME/.bash_completion.d/ ]; then
	for f in $HOME/.bash_completion.d/*; do source $f; done
fi

[ -f $HOME/opt/src/homebrew/etc/bash_completion ] && . $HOME/opt/src/homebrew/etc/bash_completion

#aliases
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

# functions
function cdfile() { cd $(dirname `which $@`); }

# vi mode
set -o vi

#PS1='\u@\h \w\$ '
#TERM="xterm"
export HISTSIZE=1000
export LANG="es_ES.UTF-8"
export LANGUAGE="es_ES"
#export LC_ALL="es_ES.UTF-8"
export MM_CHARSET="utf8"
export LC_CTYPE="es_ES.UTF-8"
#export LC_ALL=C

[ -d $HOME/opt/bin ] && PATH=$HOME/opt/bin:$PATH

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# virtualenvwrapper
[ -d $HOME/.envs ] && export WORKON_HOME=~/.envs

# brew
[ -d $HOME/opt/src/homebrew/bin ] && PATH=$HOME/opt/src/homebrew/bin:$PATH

if [[ $(uname) == "Darwin" ]]; then
    # export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages
    PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
    [ -d $(brew --prefix)/opt/gnu-sed/libexec/gnubin ] && PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"

    MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH"

    source $(brew --prefix)/bin/virtualenvwrapper.sh

    export RSTUDIO_WHICH_R=$(brew --prefix)/bin/R
fi
# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
if [[ "$(uname)" =~ "CYGWIN" ]]; then
	export GIT_SSL_NO_VERIFY=true
fi
export PATH

# exports
export S=$HOME/src
export W=$S/blog/wiki
export VIMHOME=$HOME/.vim
export D=$S/dotfiles
export B=$D/.vim/bundle
export EDITOR=vim
export PAGER=less

export LESS=" -R "

eval $(dircolors -b $HOME/.dircolors)

# git-bash-prompt
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH=$HOME/.local/bin:$PATH

[ -f $HOME/.bashrc_local ] && . $HOME/.bashrc_local
