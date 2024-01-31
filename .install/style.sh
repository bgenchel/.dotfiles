#!/bin/bash

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
export RED="$(tput setaf 1)"
export GREEN="$(tput setaf 2)"
export YELLOW="$(tput setaf 3)"
export BLUE="$(tput setaf 4)"
export BOLD="$(tput bold)"
export NORMAL="$(tput sgr0)"
else
export RED=""
export GREEN=""
export YELLOW=""
export BLUE=""
export BOLD=""
export NORMAL=""
fi

# Custom tab
export CUSTOMTAB='    '
