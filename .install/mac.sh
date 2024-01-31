#!/bin/bash

source ./style.sh

echo "installing homebrew ..."
if [ -z $(which brew) ]; then
    $(which bash) -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    export PATH=/opt/homebrew/bin:$PATH
    echo $PATH
else
    echo "${CUSTOMTAB}${GREEN}homebrew is already installed.${NORMAL}"
fi

check_install_link_brew_package() {
    local package_name="$1"

    echo "installing brew $package_name ..."
    if (! brew list "$package_name" &> /dev/null); then
        brew install "$package_name"
    else
        echo "${CUSTOMTAB}${GREEN}brew $package_name is already installed.${NORMAL}"
    fi

    sudo ln -s /opt/homebrew/bin/$package_name /usr/local/bin/$package_name
}

check_install_link_brew_package "python"
check_install_link_brew_package "python3"
check_install_link_brew_package "pyenv"
check_install_link_brew_package "pipx"
check_install_link_brew_package "go"
check_install_link_brew_package "vim"
check_install_link_brew_package "fzf"
$(brew --prefix)/opt/fzf/install
