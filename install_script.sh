if [ -z $(which brew) ]; then
    echo "attempting to install homebrew ..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [! -a /Applications/MacVim.app]; then
    echo "installing MacVim ..."
    brew install MacVim
    dir=$(sudo find / -name "MacVim.app" | grep "MacVim")
    cp $dir /Applications/
fi

echo "setting default shell to zsh ..."
sudo chsh -s /bin/zsh

echo "installing zsh plugins ..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.dotfiles/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.dotfiles/.oh-my-zsh/plugins/zsh-autosuggestions

echo "installing Meslo LG L for Powerline font ..."
curl -G https://raw.githubusercontent.com/powerline/fonts/master/Meslo/Meslo%20LG%20L%20Regular%20for%20Powerline.otf >> /Library/Fonts/MesloLGRegularforPowerline.otf
echo "set terminal font to Meslo LG L for powerline for all effects."

echo "clearing out old files ..."
if [ -a $HOME/.bashrc ]; then rm -r $HOME/.bashrc &; fi
if [ -a $HOME/.vimrc ]; then rm -r $HOME/.vimrc &; fi
if [ -a $HOME/.vim ]; then yes | rm -r $HOME/.vim &; fi
if [ -a $HOME/.tmux.conf ]; then rm -r $HOME/.tmux.conf &; fi
if [ -a $HOME/.zshrc ]; then rm -r $HOME/.zshrc &; fi
if [ -a $HOME/.oh-my-zsh]; then rm -r $HOME/.oh-my-zsh &; fi

echo "linking new files ..."
ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.vim $HOME/.vim
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.oh-my-zsh $HOME/.oh-my-zsh
