#! /usr/bin/env bash

# For debugging only remove after commit
# shopt -s expand_aliases
# alias sudo=

# OS specific installation
if [[ "$OSTYPE" == "linux"* ]]; then
  # assume it's Ubuntu lol
  sudo apt update

  # curl
  sudo apt install --assume-yes curl

  # vim
  sudo apt install --assume-yes vim

  # zsh
  sudo apt install --assume-yes zsh

  # tmux
  sudo apt install --assume-yes tmux

  # yarn
  sudo apt install --assume-yes yarn

  if grep -q Microsoft /proc/version; then
    # WSL
    echo "Not install anything on Windows"
  else
    # Actual Ubuntu

    # xclip (for copy to clipboard)
    sudo apt install --assume-yes xclip
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS

  # install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  brew update

  # curl
  brew install curl

  # vim
  brew install vim

  # zsh
  brew install zsh

  # tmux
  brew install tmux

  # yarn
  brew install yarn

fi

# vim package manager (Vundle)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install vim plugins
vim +PluginInstall +qall

# tmux package manager (tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# prezto (requires zsh)
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# rupa
git clone https://github.com/rupa/z.git ~/z

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# tldr
yarn global add tldr

# diff-so-fancy (.gitconfig dependency)
yarn global add diff-so-fancy