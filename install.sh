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

export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/zsh/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom


if [ $(uname) == "Darwin" ]; then # Darwin is the kernal that Mac's commonly use
    echo "${BOLD}***** Running Installation for Mac *****${NORMAL}"
    chmod +x ./.install/mac.sh
    ./.install/mac.sh
    installer=$(which brew)
else 
    echo "${BOLD}***** Running Installation for Linux *****${NORMAL}"
    chmod +x ./.install/linux.sh
    ./.install/linux.sh
    if [ $(which apt-get) ]; then
        echo ">> found ${BOLD}apt-get${NORMAL}; this is probably a ${BOLD}Debian${NORMAL} based OS."
        installer=$(which apt-get)
    elif [ $(which yum) ]; then
        echo ">> found ${BOLD}yum${NORMAL}; this is probably a ${BOLD}Red Hat${NORMAL} based OS."
        installer=$(which yum)
    else
        echo ">> could not find a known package manager. Exiting ..."
        exit 1
    fi
fi

echo "installing tmux ..."
if [ -z $(which tmux) ]; then
    yes | $installer install tmux
else
    echo "${CUSTOMTAB}${GREEN}tmux is already installed.${NORMAL}"
fi

echo "installing oh-my-zsh ..."
if [ ! -d $ZSH ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
else
    echo "${CUSTOMTAB}${GREEN}.oh-my-zsh is already installed.${NORMAL}"
fi

echo "installing zsh syntax highlighting ..."
if [ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
else
    echo "${CUSTOMTAB}${GREEN}zsh syntax highlighting is already installed.${NORMAL}"
fi

echo "installing zsh autosuggestions ..."
if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
    echo "${CUSTOMTAB}${GREEN}zsh autosuggestions is already installed.${NORMAL}"
fi

echo "installing the powerlevel10k zsh theme ..."
if [ ! -d $ZSH/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k
else
    echo "${CUSTOMTAB}${GREEN}powerlevel10k zsh theme is already installed.${NORMAL}"
fi

echo "installing fzf ..."
if [ ! -d $HOME/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    ./$HOME/.fzf/install
    cd $HOME/.fzf/src
    make
    make install
    make release
    make release-all
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
else
    echo "${CUSTOMTAB}${GREEN}fzf is already installed.${NORMAL}"
fi

echo "installing YouCompleteMe supporting libraries..."
# C-family Language Support
yes | $installer install llvm
yes | $installer install cmake
# Javascript / Typescript Support
yes | $installer install node
yes | $installer install npm
yes | npm install -g typescript

# Installing tmux extras
echo "installing tmux extras ..."
npm install -g tmux-cpu
npm install -g tmux-mem

echo "installing Vim plugins ..."
vim +PlugInstall +qall
vim +PlugClean +qall
vim +PlugInstall +qall

echo "building YouCompleteMe ..."
python $DOTFILES/vim/.vim/plugged/YouCompleteMe/install.py --clang-completer --tern-completer

chmod +x ./refresh.sh
./refresh.sh

echo ""
echo ""
echo "FOR ALL FEATURES TO WORK: "
echo "    - Set default shell to zsh (run: chsh -s /bin/zsh)"
echo "    - Quit and restart terminal "
echo ""
echo ""
