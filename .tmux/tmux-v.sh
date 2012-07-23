#!/bin/bash
echo "tmux launcher"
echo
echo "    p ) tmux split-window 'ipython' "
echo "    s ) tmux split-window 'vim +VimShell' "
echo "    S ) tmux new-window 'vim +VimShell' "
echo "    q ) quit launcher"
echo "    * ) tmux new-window 'vim' "
read -n 1 input
case $input in
    p ) tmux split-window 'ipython' ;;
    s ) tmux split-window 'vim +VimShell' ;;
    S ) tmux new-window 'vim +VimShell' ;;
    q ) ;;
    * ) tmux new-window "vim" ;;
esac
