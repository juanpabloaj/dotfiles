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
export LESS_TERMCAP_so=$'\E[38;5;246m'          # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'       # begin underline

############################## ##################################
# ##### PROMPT SECTION ##### ####################################
############################## ##################################

# color_name='\[\033[ color_code m\]Ô

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

#[ -n "$PS1" ] && PS1='${rgb_usr}`whoami`${rgb_std} \W ${rgb_usr}\\\$${rgb_restore} '
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
# funcion de autocompletado para ssh 
#_compssh ()
#{
#cur=${COMP_WORDS[COMP_CWORD]};
#COMPREPLY=($(compgen -W "$(cat ~/.ssh/config | grep host | sed '/hostna/d;s/host //')" -- $cur))
#}
#complete -F _compssh ssh

eval $(dircolors  $HOME/.dircolors)

if [ -d $HOME/.bash_completion.d/ ]
then 
	. $HOME/.bash_completion.d/*
fi

if [ $(uname) == "Darwin" ]
then 
	alias gitk='/usr/bin/wish $(which gitk)'	
fi 

#aliases
alias ls='ls --color=auto'
#alias ls='ls -G'
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -a'
alias screen='$HOME/opt/bin/screen'
alias grep='grep --color'
PS1='\u@\h \w\$ '
TERM="xterm"
EDITOR=vim
PATH=$PATH:$HOME/opt/bin
#PATH=$PATH:$HOME/bin
export WIKI=$HOME/src/pixelmuerto.github.com/wiki
export HISTSIZE=2000
export PATH
alias xtermHuge='xterm -fn *-*-*-*-*-*-20-*'
alias xtermHugeWhite='xtermHuge -bg white -fg black'
alias xtermWhite='xterm -bg white -fg black'
export VIMHOME=$HOME/.vim
export RC=$HOME/src/rc
[[ $- == *i* ]] && . $HOME/src/git-prompt/git-prompt.sh
