#!/bin/bash

echo "installing Homebrew ..."
if [ -z $(which brew) ]; then
    /usr/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "${CUSTOMTAB}${GREEN}Homebrew is already installed.${NORMAL}"
fi

echo "installing Brew Python ..."
if (brew list python &> /dev/null); then
    brew install python
else
    echo "${CUSTOMTAB}${GREEN}Brew Python is already installed.${NORMAL}"
fi

echo "installing Brew Go ..."
if (brew list go &> /dev/null); then
    brew install go
else
    echo "${CUSTOMTAB}${GREEN}Brew Go is already installed.${NORMAL}"
fi

echo "installing MacVim ..."
if [ ! -d /Applications/MacVim.app ]; then
    brew install MacVim
    dir=$(sudo find / -name "MacVim.app" | grep "MacVim")
    cp -r $dir /Applications/
else
    echo "${CUSTOMTAB}${GREEN}MacVim is already installed.${NORMAL}"
fi
