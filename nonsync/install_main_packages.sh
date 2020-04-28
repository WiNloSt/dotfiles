#! /usr/bin/env bash

# For debugging only remove after commit
# shopt -s expand_aliases
# alias sudo=

# OS specific installation
if [[ "$OSTYPE" == "linux"* ]]; then
  # add other apt repository before update

  ## yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

  ## github/hub
  sudo add-apt-repository ppa:cpick/hub
  sudo apt-get update

  # assume it's Ubuntu lol
  sudo apt update

  # zsh
  sudo apt install zsh

  # yarn
  sudo apt install --assume-yes yarn

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

  # some other stuff
  sudo apt install --assume-yes build-essential
  sudo apt install --assume-yes python3.7
  sudo apt install --assume-yes python3
  sudo apt install --assume-yes python3-pip

  # github/hub
  sudo apt-get install hub

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
