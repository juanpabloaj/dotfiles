#!/bin/bash
[[ -r ~/.bashrc ]] && . ~/.bashrc

if [ -x "$(command -v brew)" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
  fi
fi
