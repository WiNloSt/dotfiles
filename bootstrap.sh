#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude "update_apm_packages.sh" \
		--exclude ".bashshrc.windows" --exclude "nonsync/" -avh --no-perms . ~
	source ~/.bash_profile
}

unset doIt
