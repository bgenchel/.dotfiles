export DOTFILES=/.dotfiles
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
# sudo chsh -s /bin/zsh

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

if [ -z $(sudo find / -name "MesloLGRegularforPowerline.otf" | grep "Meslo") ]; then
    echo "installing Meslo LG L for Powerline font ..."
    curl -G https://raw.githubusercontent.com/powerline/fonts/master/Meslo/Meslo%20LG%20L%20Regular%20for%20Powerline.otf >> /Library/Fonts/MesloLGRegularforPowerline.otf
fi

# if [ -z $(which go) ]; then
    # echo "installing go ..."
# fi

if [ ! -d /.fzf ]; then
    echo "installing fzf ..."
    git clone --depth 1 https://github.com/junegunn/fzf.git /.fzf
    /.fzf/install
    cd /.fzf/src
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
# if [ -a /.bashrc ]; then rm -r /.bashrc; fi
if $(test -e /.vimrc ); then rm -r /.vimrc; fi
if $(test -e /.vim ); then yes | rm -r /.vim; fi
if $(test -e /.tmux.conf); then rm -r /.tmux.conf; fi
if $(test -e /.zshrc); then rm -r /.zshrc; fi
if $(test -e /.oh-my-zsh); then yes | rm -r /.oh-my-zsh; fi

echo "linking new files ..."
# ln -s $DOTFILES/.bashrc /.bashrc
ln -s $DOTFILES/.vimrc /.vimrc
ln -s $DOTFILES/.vim /.vim
ln -s $DOTFILES/.tmux.conf /.tmux.conf
ln -s $DOTFILES/.zshrc /.zshrc
ln -s $DOTFILES/.oh-my-zsh /.oh-my-zsh

echo ""
echo ""
echo "REMINDER - FOR ALL FEATURES TO WORK: "
echo "    - Set default shell to zsh (run: chsh -s /bin/zsh)"
echo "    - Set terminal font to 'Meslo LG L for Powerline'"
echo ""
echo ""

