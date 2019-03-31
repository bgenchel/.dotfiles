export DOTFILES=$HOME/.dotfiles
export ZSH_CUSTOM=$DOTFILES/.oh-my-zsh/custom

if [ -z $(which brew) ]; then
    echo "installing homebrew ..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -z $(which tmux) ]; then
    echo "installing tmux ..."
    brew install tmux
fi

if [ ! -d /Applications/MacVim.app ]; then
    echo "installing MacVim ..."
    brew install MacVim
    dir=$(sudo find / -name "MacVim.app" | grep "MacVim")
    cp $dir /Applications/
fi

# echo "setting default shell to zsh ..."
# sudo chsh -s /bin/zsh

if [ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]; then
    echo "installing zsh syntax highlighting ..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
    echo "installing zsh autosuggestions ..."
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ -z $(sudo find / -name "MesloLGRegularforPowerline.otf" | grep "Meslo") ]; then
    echo "installing Meslo LG L for Powerline font ..."
    curl -G https://raw.githubusercontent.com/powerline/fonts/master/Meslo/Meslo%20LG%20L%20Regular%20for%20Powerline.otf >> /Library/Fonts/MesloLGRegularforPowerline.otf
fi

if [ ! -d $HOME/.fzf ]; then
    echo "installing fzf ..."
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    ./$HOME/.fzf/install
    cd $HOME/.fzf/src
    make
    make install
    make release
    make release-all
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
fi

echo "installing YouCompleteMe supporting libraries..."
# C-family Language Support
yes | brew install clang
yes | brew install build-essential cmake
# Javascript / Typescript Support
yes | brew install node
yes | apt-get install npm
yes | npm install -g typescript

echo "installing Vim plugins ..."
vim +PlugInstall +qall
vim +PlugClean +qall
vim +PlugInstall +qall

echo "building YouCompleteMe ..."
python $DOTFILES/.vim/plugged/YouCompleteMe/install.py --clang-completer --tern-completer

echo "clearing out old files ..."
if [ -a $HOME/.bashrc ]; then rm -r $HOME/.bashrc; fi
if [ -a $HOME/.vimrc ]; then rm -r $HOME/.vimrc; fi
if [ -a $HOME/.vim ]; then yes | rm -r $HOME/.vim; fi
if [ -a $HOME/.tmux.conf ]; then rm -r $HOME/.tmux.conf; fi
if [ -a $HOME/.zshrc ]; then rm -r $HOME/.zshrc; fi
if [ -a $HOME/.oh-my-zsh ]; then yes | rm -r $HOME/.oh-my-zsh; fi

echo "linking new files ..."
ln -s $DOTFILES/.bashrc $HOME/.bashrc
ln -s $DOTFILES/.vimrc $HOME/.vimrc
ln -s $DOTFILES/.vim $HOME/.vim
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/.zshrc $HOME/.zshrc
ln -s $DOTFILES/.oh-my-zsh $HOME/.oh-my-zsh

echo ""
echo ""
echo "REMINDER - FOR ALL FEATURES TO WORK: "
echo "    - Set default shell to zsh (run: chsh -s /bin/zsh)"
echo "    - Set terminal font to 'Meslo LG L for Powerline'"
echo "    - Open Vim and run :PlugInstall"
echo ""
echo ""
