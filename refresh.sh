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
if $(test -e $HOME/.tmp/.oh-my-zsh/custom); then
    rm -rf $HOME/.oh-my-zsh/custom
    mv $HOME/.tmp/.oh-my-zsh/custom $HOME/.oh-my-zsh
fi

echo "installing Vim plugins ..."
wait && vim -c "PlugInstall" +qall
wait && vim -c "PlugClean" +qall
wait && vim -c "PlugInstall" +qall

wait
echo "building YouCompleteMe ..."
# Check if you're in a conda environment
if (python -c "import sys, os.path as op; sys.exit(0) if op.exists(op.join(sys.prefix, 'conda-meta')) else sys.exit(1)"); then 
    if [[ -a $HOME/anaconda ]]; then
        . $HOME/anaconda/etc/profile.d/conda.sh
    elif [[ -a $HOME/anaconda3 ]]; then
        . $HOME/anaconda3/etc/profile.d/conda.sh
    fi
    conda deactivate
fi

wait
$(which python) $HOME/.vim/plugged/YouCompleteMe/install.py --clang-completer --tern-completer
