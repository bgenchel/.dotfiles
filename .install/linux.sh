#!/bin/bash

source ./style.sh

echo "installing zsh ..."
if [ -z $(which zsh) ]; then
    yes | apt-get install zsh
else
    echo "${CUSTOMTAB}${GREEN}zsh is already installed.${NORMAL}"
fi
