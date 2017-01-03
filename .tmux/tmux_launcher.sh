#!/bin/bash
echo "tmux launcher"
echo
echo "    p ) tmux split-window 'ipython' "
echo "    q ) quit launcher"
echo "    s ) tmux split-window 'vim +VimShell' "
echo "    S ) tmux new-window 'vim +VimShell' "
echo "    w ) tmux split-window 'nvim $W'"
echo "    z ) tmux split-window 'zsh'"
echo "    * ) tmux new-window 'vim' "
read -n 1 input
case $input in
    p ) tmux split-window -p 100 'ipython' ;;
    s ) tmux split-window -p 100 'vim +VimShell' ;;
    S ) tmux new-window 'vim +VimShell' ;;
    q ) ;;
    w ) tmux split-window -p 100 'nvim $W' ;;
    z ) tmux split-window -p 100 'zsh' ;;
    * ) tmux new-window "vim" ;;
esac
