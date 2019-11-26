#!/bin/bash

export DOTFILES=$HOME/.dotfiles

echo "clearing out old files ..."
if $(test -e $HOME/.bashrc ); then rm -r $HOME/.bashrc; fi
if $(test -e $HOME/.vimrc ); then rm -r $HOME/.vimrc; fi
if $(test -e $HOME/.vim ); then yes | rm -r $HOME/.vim; fi
if $(test -e $HOME/.tmux.conf); then rm -r $HOME/.tmux.conf; fi
if $(test -e $HOME/.tmux.conf.local); then rm -r $HOME/.tmux.conf.local; fi
if $(test -e $HOME/.zshrc); then rm -r $HOME/.zshrc; fi
if $(test -e $HOME/.zshrc.extras); then rm -r $HOME/.zshrc.extras; fi
if $(test -e $HOME/.p10k.zsh); then rm -r $HOME/.p10k.zsh; fi
if $(test -e $HOME/.oh-my-zsh); then 
    if $(test -e $HOME/.oh-my-zsh/custom); then
        mkdir -p $HOME/.tmp/.oh-my-zsh
        mv $HOME/.oh-my-zsh/custom $HOME/.tmp/.oh-my-zsh/custom
    fi
    yes | rm -r $HOME/.oh-my-zsh
fi

echo "placing new files ..."
cp $DOTFILES/bash/.bashrc $HOME/.bashrc
cp $DOTFILES/vim/.vimrc $HOME/
cp -r $DOTFILES/vim/.vim $HOME/
cp $DOTFILES/tmux/.tmux.conf $HOME/
cp $DOTFILES/tmux/.tmux.conf.local $HOME/
cp $DOTFILES/zsh/.zshrc $HOME/
cp $DOTFILES/zsh/.zshrc.extras $HOME/
cp $DOTFILES/zsh/.p10k.zsh $HOME/
cp -r $DOTFILES/zsh/.oh-my-zsh $HOME/
if $(test -e $HOME/.tmp/.oh-my-zsh/custom); then
    rm -rf $HOME/.oh-my-zsh/custom
    mv $HOME/.tmp/.oh-my-zsh/custom $HOME/.oh-my-zsh
fi
