#!/usr/bin/env bash
regex=(.*)@
apm list -bi | while read line; do
  if [[ $line =~ $regex ]]; then
    packageWithoutVersion=${BASH_REMATCH[1]}
    if ! grep -qe $packageWithoutVersion .atom/packages.list
    then
      apm uninstall $packageWithoutVersion
    fi
  fi
done
