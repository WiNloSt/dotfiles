#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
    --exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude "update_apm_packages.sh" \
    --exclude ".bashshrc.windows" --exclude "nonsync/" -avh --no-perms . ~
  source ~/.bash_profile

  # copy .tmux.conf using template
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    CLIP_COMMAND=pbcopy
    eval "echo \"$(cat nonsync/.tmux.conf.template)\"" > ~/.tmux.conf
  elif [[ "$OSTYPE" == "linux"* ]] && grep -q microsoft /proc/version; then
    # WSL
    CLIP_COMMAND=clip.exe
    eval "echo \"$(cat nonsync/.tmux.conf.template)\"" > ~/.tmux.conf
  elif [[ "$OSTYPE" == "linux"* ]]; then
    # Ubuntu
    CLIP_COMMAND="xclip -selection clipboard"
    eval "echo \"$(cat nonsync/.tmux.conf.template)\"" > ~/.tmux.conf
  fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo "";

  if [[ $REPLY =~ ^[Yy]$ ]]; then
      doIt
  fi

  read -p "Install essential packages? (y/n) " -n 1
  echo "";

  if [[ $REPLY =~ ^[Yy]$ ]]; then
      bash nonsync/install_main_packages.sh
  fi
fi

unset doIt
