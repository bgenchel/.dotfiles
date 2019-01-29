export DOTFILES=$HOME/.dotfiles
export ZSH_CUSTOM=$DOTFILES/.oh-my-zsh/custom

# if [ -z $(which brew) ]; then
    # echo "installing homebrew ..."
    # /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# fi
if [ -z $(which tmux) ]; then
    echo "installing tmux ..."
    yes | apt-get install tmux
fi

# echo "setting default shell to zsh ..."
# chsh -s /bin/zsh
if [ -z $(which zsh) ]; then
    echo "installing zsh ..."
    yes | apt-get install zsh
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]; then
    echo "installing zsh syntax highlighting ..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
    echo "installing zsh autosuggestions ..."
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

echo "placing Meslo LG L for Powerline font ..."
cp fonts/MesloLGRegularforPowerline.otf /usr/share/fonts/

# if [ ! -d /.fzf ]; then
#     echo "installing fzf ..."
#     git clone --depth 1 https://github.com/junegunn/fzf.git /.fzf
#     /.fzf/install
#     /.fzf/src/make
#     /.fzf/src/make install
#     /.fzf/src/make release
#     /.fzf/src/make release-all
#     export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# fi

###
# seems like it is not necessary to install this way. Should just install 
# with vim :PlugInstall
###
# echo "cloning YouCompleteMe ..."
# mkdir $DOTFILES/.vim/plugged/youcompleteme
# git clone https://github.com/Valloric/YouCompleteMe.git $DOTFILES/.vim/plugged/YouCompleteMe
# cd $DOTFILES/.vim/plugged/YouCompleteMe && git submodule update --init --recursive

echo "installing YouCompleteMe supporting libraries..."
# C-family Language Support
yes | apt-get install clang
yes | apt-get install build-essential cmake
# Javascript / Typescript Support
yes | apt-get install nodejs
yes | apt-get install npm
yes | npm install -g typescript

echo "clearing out old files + dirs ..."
if $(test -e /.bashrc ); then rm -r /.bashrc; fi
if $(test -e /.vimrc ); then rm -r $HOME/.vimrc; fi
if $(test -e /.vim ); then yes | rm -r $HOME/.vim; fi
if $(test -e /.tmux.conf); then rm -r $HOME/.tmux.conf; fi
if $(test -e /.zshrc); then rm -r $HOME/.zshrc; fi
if $(test -e /.oh-my-zsh); then yes | rm -r $HOME/.oh-my-zsh; fi

echo "placing new files + dirs ..."
cp $DOTFILES/.bashrc $HOME/.bashrc
cp $DOTFILES/.vimrc $HOME/
cp -r $DOTFILES/.vim $HOME/
cp $DOTFILES/.tmux.conf $HOME/
cp $DOTFILES/.zshrc $HOME/
cp -r $DOTFILES/.oh-my-zsh $HOME/

echo "installing Vim plugins ..."
vim +PlugInstall +qall
vim +PlugClean +qall
vim +PlugInstall +qall

echo "building YouCompleteMe ..."
python $HOME/.vim/plugged/YouCompleteMe/install.py --clang-completer --ts-completer

echo ""
echo ""
echo "REMINDER - FOR ALL FEATURES TO WORK: "
echo "    - Set default shell to zsh (run: chsh -s /bin/zsh)"
echo "    - Set terminal font to 'Meslo LG L for Powerline'"
echo ""
echo ""

