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

if [ ! -d $HOME/.dotfiles/.oh-my-zsh/plugins/zsh-syntax-highlighting ]; then
    echo "installing zsh syntax highlighting ..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.dotfiles/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

if [ ! -d $HOME/.dotfiles/.oh-my-zsh/plugins/zsh-autosuggestions ]; then
    echo "installing zsh autosuggestions ..."
    git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.dotfiles/.oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -z $(sudo find / -name "MesloLGRegularforPowerline.otf" | grep "Meslo") ]; then
    echo "installing Meslo LG L for Powerline font ..."
    curl -G https://raw.githubusercontent.com/powerline/fonts/master/Meslo/Meslo%20LG%20L%20Regular%20for%20Powerline.otf >> /Library/Fonts/MesloLGRegularforPowerline.otf
fi

echo "clearing out old files ..."
if [ -a $HOME/.bashrc ]; then rm -r $HOME/.bashrc; fi
if [ -a $HOME/.vimrc ]; then rm -r $HOME/.vimrc; fi
if [ -a $HOME/.vim ]; then yes | rm -r $HOME/.vim; fi
if [ -a $HOME/.tmux.conf ]; then rm -r $HOME/.tmux.conf; fi
if [ -a $HOME/.zshrc ]; then rm -r $HOME/.zshrc; fi
if [ -a $HOME/.oh-my-zsh ]; then yes | rm -r $HOME/.oh-my-zsh; fi

echo "linking new files ..."
ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.vim $HOME/.vim
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.oh-my-zsh $HOME/.oh-my-zsh

echo ""
echo ""
echo "REMINDER - FOR ALL FEATURES TO WORK: "
echo "    - Set terminal font to 'Meslo LG L for Powerline'"
echo "    - Set default shell to zsh (run: chsh -s /bin/zsh)"
echo ""
echo ""

