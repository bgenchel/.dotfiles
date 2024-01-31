#!/bin/bash

export DOTFILES=$HOME/.dotfiles

echo "clearing out old files ..."
chmod +x $DOTFILES/.install/remove.sh && $DOTFILES/.install/remove.sh

wait
echo -e "placing new files ...\n"
cp $DOTFILES/bash/.bashrc $HOME/.bashrc
cp $DOTFILES/vim/.vimrc $HOME/
cp -r $DOTFILES/vim/.vim $HOME/
cp $DOTFILES/tmux/.tmux.conf $HOME/
cp $DOTFILES/tmux/.tmux.conf.local $HOME/
cp $DOTFILES/zsh/.zshrc $HOME/
cp $DOTFILES/zsh/.zshrc.extras $HOME/
cp $DOTFILES/zsh/.p10k.zsh $HOME/
cp -r $DOTFILES/zsh/.oh-my-zsh $HOME/

pipx ensurepath

echo "installing Vim plugins ..."
wait && vim -c "PlugInstall" +qall
wait && vim -c "PlugClean" +qall
wait && vim -c "PlugInstall" +qall

echo "building YouCompleteMe ..."
$(which python) $HOME/.vim/plugged/YouCompleteMe/install.py --clang-completer --ts-completer
