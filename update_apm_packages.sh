#!/usr/bin/env bash

apm list -ib > .atom/packages.list

# copy all config files
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  find ~/.atom -maxdepth 1 -type f -name "*.cson"  | xargs -I {} cp {} .atom/
  find ~/.atom -maxdepth 1 -type f -name "*.coffee" | xargs -I {} cp {} .atom/
  find ~/.atom -maxdepth 1 -type f -name "*.less" | xargs -I {} cp {} .atom/
elif [[ "$OSTYPE" == "darwin"* ]]; then
  find ~/.atom -type f -d 1 -name "*.cson" | xargs -I {} cp {} .atom/
  find ~/.atom -type f -d 1 -name "*.coffee" | xargs -I {} cp {} .atom/
  find ~/.atom -type f -d 1 -name "*.less" | xargs -I {} cp {} .atom/
fi

# delete projecct manager config since it should be machine specific
rm .atom/projects.cson
