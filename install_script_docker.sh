export WD=$(cd .. && echo $PWD)
export DOTFILES=$WD/.dotfiles
export ZSH_CUSTOM=$DOTFILES/.oh-my-zsh/custom

# if [ -z $(which brew) ]; then
    # echo "installing homebrew ..."
    # /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# fi
if [ -z $(which tmux) ]; then
    echo "installing tmux ..."
    apt-get install tmux
fi

# echo "setting default shell to zsh ..."
# sudo chsh -s /bin/zsh

if [ -z $(which zsh) ]; then
    echo "installing zsh ..."
    apt-get install zsh
fi

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

# if [ -z $(which go) ]; then
    # echo "installing go ..."
# fi

if [ ! -d $WD/.fzf ]; then
    echo "installing fzf ..."
    git clone --depth 1 https://github.com/junegunn/fzf.git $WD/.fzf
    ./$WD/.fzf/install
    cd $WD/.fzf/src
    make
    make install
    make release
    make release-all
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
fi

# echo "installing Vim plugins ..."
# vim +PlugInstall +qall
# vim +PlugClean +qall
# vim +PlugInstall +qall

echo "building YouCompleteMe ..."
python $DOTFILES/.vim/plugged/youcompleteme/install.py --clang-completer --tern-completer

echo "clearing out old files ..."
# if [ -a $WD/.bashrc ]; then rm -r $WD/.bashrc; fi
if [ -a $WD/.vimrc ]; then rm -r $WD/.vimrc; fi
if [ -a $WD/.vim ]; then yes | rm -r $WD/.vim; fi
if [ -a $WD/.tmux.conf ]; then rm -r $WD/.tmux.conf; fi
if [ -a $WD/.zshrc ]; then rm -r $WD/.zshrc; fi
if [ -a $WD/.oh-my-zsh ]; then yes | rm -r $WD/.oh-my-zsh; fi

echo "linking new files ..."
# ln -s $DOTFILES/.bashrc $WD/.bashrc
ln -s $DOTFILES/.vimrc $WD/.vimrc
ln -s $DOTFILES/.vim $WD/.vim
ln -s $DOTFILES/.tmux.conf $WD/.tmux.conf
ln -s $DOTFILES/.zshrc $WD/.zshrc
ln -s $DOTFILES/.oh-my-zsh $WD/.oh-my-zsh

echo ""
echo ""
echo "REMINDER - FOR ALL FEATURES TO WORK: "
echo "    - Set default shell to zsh (run: chsh -s /bin/zsh)"
echo "    - Set terminal font to 'Meslo LG L for Powerline'"
echo ""
echo ""

