#!/bin/bash

export DOTFILES=$HOME/.dotfiles
export DF_ZSH=$DOTFILES/zsh
export DF_OM_ZSH=$DF_ZSH/.oh-my-zsh
export DF_OM_ZSH_CUSTOM=$DF_OM_ZSH/custom

source $DOTFILES/.install/style.sh

if [ $(uname) == "Darwin" ]; then # Darwin is the kernal that Mac's commonly use
    echo "${BOLD}***** Running Installation for Mac *****${NORMAL}"
    chmod +x $DOTFILES/.install/mac.sh && source $DOTFILES/.install/mac.sh
    installer=$(which brew)

else 
    echo "${BOLD}***** Running Installation for Linux *****${NORMAL}"
    chmod +x $DOTFILES/.install/linux.sh && $DOTFILES/.install/linux.sh
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
if [ ! -d $DF_OM_ZSH ]; then
    ZSH=$DF_OM_ZSH sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
else
    echo "${CUSTOMTAB}${GREEN}.oh-my-zsh is already installed.${NORMAL}"
fi

echo "adding custom files to oh-my-zsh ..."
cp $DF_ZSH/aliases.zsh $DF_OM_ZSH_CUSTOM/
if [ ! -f $DF_OM_ZSH_CUSTOM/custom.zsh ]; then
    touch $DF_OM_ZSH_CUSTOM/custom.zsh
fi

echo "installing zsh syntax highlighting ..."
if [ ! -d $DF_OM_ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $DF_OM_ZSH_CUSTOM/plugins/zsh-syntax-highlighting
else
    echo "${CUSTOMTAB}${GREEN}zsh syntax highlighting is already installed.${NORMAL}"
fi

echo "installing zsh autosuggestions ..."
if [ ! -d $DF_OM_ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $DF_OM_ZSH_CUSTOM/plugins/zsh-autosuggestions
else
    echo "${CUSTOMTAB}${GREEN}zsh autosuggestions is already installed.${NORMAL}"
fi

echo "Installing powerlevel9k theme for zsh versions lower than 5.1 ..."
if [ -d $DF_OM_ZSH/themes/powerlevel9k ]; then
    rm -rf $DF_OM_ZSH/themes/powerlevel9k 
fi
git clone --depth=1 https://github.com/Powerlevel9k/powerlevel9k.git $DF_OM_ZSH/themes/powerlevel9k

echo "Installing the powerlevel10k zsh theme ..."
if [ -d $DF_OM_ZSH/themes/powerlevel10k ]; then
    rm -rf $DF_OM_ZSH/themes/powerlevel10k 
fi
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $DF_OM_ZSH/themes/powerlevel10k

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

echo "Installing Vim-Plug ..."
curl -fLo $DOTFILES/vim/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "installing YouCompleteMe supporting libraries..."
# C-family Language Support
yes | $installer install llvm
yes | $installer install cmake
# Javascript / Typescript Support
yes | $installer install node
yes | $installer install npm
yes | npm install -g typescript
# Other
yes | $installer install go

# Installing tmux extras
echo "installing tmux extras ..."
npm install -g tmux-cpu
npm install -g tmux-mem

# Place files and finish install
chmod +x $DOTFILES/refresh.sh && $DOTFILES/refresh.sh 

echo ""
echo ""
echo "FOR ALL FEATURES TO WORK: "
echo "    - Set default shell to zsh (run \`chsh -s /bin/zsh\` or edit /etc/passwd)"
echo "    - Quit and restart terminal "
echo ""
echo ""
