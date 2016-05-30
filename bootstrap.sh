#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude "update_apm_packages.sh" \
		--exclude ".bashshrc.windows" -avh --no-perms . ~;
	source ~/.bash_profile;

	read -p "Do you want to update Atom packages? This will take a while. (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		installAtomPackages;
	fi;
}

function installAtomPackages() {
	# install Atom packages
	cd .atom
	source package_installer.sh;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
unset installAtomPackages;
