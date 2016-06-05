#!/usr/bin/env bash

while read line; do
  # Github packages is separate from apm packages with empty line
  if [[ -z $line ]]; then
    isGithubPackage=true
  fi

  package=
  if [[ $line =~ ^([a-zA-Z0-9-]+) ]]; then
    package=${BASH_REMATCH[0]}
  fi

  if [[ $isGithubPackage && -n $package ]]; then
    # install Github packages
    if [[ ! -d "$HOME/.atom/packages/$package" ]]; then
      if [[ $line =~ [[:blank:]](.*) ]]; then
        githubPackageRepo=${BASH_REMATCH[0]}
        apm install $githubPackageRepo
      fi
    fi
  elif [[ -n $package ]]; then
    # install missing packages
    if [[ ! -d "$HOME/.atom/packages/$package" ]]; then
      apm install $package
    fi
  fi
done < packages.list

apm upgrade -c false
