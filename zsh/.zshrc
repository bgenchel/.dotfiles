# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ $(uname) = "Darwin" ]]; # Darwin is the kernal that Mac's commonly use
then 
    if [[ -a $HOME/anaconda ]]; then
        . $HOME/anaconda/etc/profile.d/conda.sh
    elif [[ -a $HOME/anaconda3 ]]; then
        . $HOME/anaconda3/etc/profile.d/conda.sh
    fi
    conda activate

    alias vim="/Applications/MacVim.app/Contents/MacOS/Vim";

    export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$PATH
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f "$HOME/.ssh/y/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/.ssh/y/google-cloud-sdk/path.zsh.inc"; fi
    # The next line enables shell command completion for gcloud.
    if [ -f "$HOME/.ssh/y/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/.ssh/y/google-cloud-sdk/completion.zsh.inc"; fi

    export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
    export DISPLAY=":0" 
elif [[ $(uname) = "Linux" ]]; then
    export EDITOR=$(which vim)
fi

# User configuration
# Try to make a custom prompt with shortening
setopt PROMPT_SUBST
PROMPT='%{$(pwd|grep --color=always /)%${#PWD}G%} %(!.%F{red}.%F{cyan})%n%f@%F{yellow}%m%f%(!.%F{red}.)%#%f '

DEFAULT_USER=$USER

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# If the aliases.zsh file does not exist in the ZSH_CUSTOM dir yet, create and
# initialize it. Put all system specific aliases in this file.
if [[ ! -a $ZSH_CUSTOM/aliases.zsh ]]; then
    touch $ZSH_CUSTOM/aliases.zsh
    echo "# For a full list of active aliases, run 'alias'." >> $ZSH_CUSTOM/aliases.zsh
    echo "#" >> $ZSH_CUSTOM/aliases.zsh
    echo "# Example aliases:" >> $ZSH_CUSTOM/aliases.zsh
    echo "# alias zshconfig=\"mate ~/.zshrc\"" >> $ZSH_CUSTOM/aliases.zsh
    echo "# alias ohmyzsh=\"mate ~/.oh-my-zsh\"" >> $ZSH_CUSTOM/aliases.zsh
fi

# If the custom.zsh file does not exist in the ZSH_CUSTOM dir yet, create it.
# Place all system specific non-alias commands/instructions in this file.
if [[ ! -a $ZSH_CUSTOM/custom.zsh ]]; then
    touch $ZSH_CUSTOM/custom.zsh
fi

autoload throw catch

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# this needs to go after the plugins declaration or it won't work automatically
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function cleanVIM() {
  echo "Cleaning ~/.vimbackup/"
  rm -Rf ~/.vimbackup/*
  echo "Cleaning ~/.vimswap/"
  rm -Rf ~/.vimswap/*
  echo "Cleaning ~/.vimviews/"
  rm -Rf ~/.vimviews/*
  echo "Cleaning ~/.vimundo/"
  rm -Rf ~/.vimundo/*
  echo "All done!"

}

# For PowerLevel10K Theme - To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Add custom scripts to path
export PATH=$PATH:$HOME/.bin

# zshrc extra options
source $HOME/.zshrc.extras
