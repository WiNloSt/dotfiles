#!/usr/bin/env bash

while read packageWithVersion; do
  if [[ -z $packageWithVersion ]]; then
    isGithubPackage=true
  fi

  package=
  if [[ $packageWithVersion =~ ^([a-zA-Z0-9-]+) ]]
  then
    package=${BASH_REMATCH[0]}
  fi

  if [[ $isGithubPackage && -n $package ]]; then
    # install Github packages
    apm upgrade -c false $package
  elif [[ -n $package ]]; then
    # install missing packages
    if [[ ! -d "$HOME/.atom/packages/$package" ]]
    then
      apm install $package
    fi
  fi
done <packages.list
