#!/bin/bash

export DOTFILES=$HOME/.dotfiles

echo "clearing out old files ..."
if $(test -e /.bashrc ); then rm -r /.bashrc; fi
if $(test -e /.vimrc ); then rm -r $HOME/.vimrc; fi
if $(test -e /.vim ); then yes | rm -r $HOME/.vim; fi
if $(test -e /.tmux.conf); then rm -r $HOME/.tmux.conf; fi
if $(test -e /.zshrc); then rm -r $HOME/.zshrc; fi
if $(test -e /.oh-my-zsh); then yes | rm -r $HOME/.oh-my-zsh; fi

echo "placing new files ..."
cp $DOTFILES/.bashrc $HOME/.bashrc
cp $DOTFILES/.vimrc $HOME/
cp -r $DOTFILES/.vim $HOME/
cp $DOTFILES/.tmux.conf $HOME/
cp $DOTFILES/.zshrc $HOME/
cp -r $DOTFILES/.oh-my-zsh $HOME/
