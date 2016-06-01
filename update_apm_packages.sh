#!/usr/bin/env bash

# update installed packages list
apm list -ib > .atom/packages.list

# replace github package name with it's repository
regex="^.── ([a-zA-Z0-9@.-]+).+\((.*)#.*\)"

apm list | sed -e '1,/Git/d' | while read line; do
  if [[ $line =~ $regex ]]; then
    packageName=${BASH_REMATCH[1]}
    packageRepo=${BASH_REMATCH[2]}
    sed -i '' "s#$packageName#$packageRepo#g" .atom/packages.list
  fi
done

# copy all config files except projects.cson (project manager) since each machine will have different project settings
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  find ~/.atom -maxdepth 1 -type f -name "*.cson" | grep projects.cson --invert-match | xargs -I {} cp {} .atom/
  find ~/.atom -maxdepth 1 -type f -name "*.coffee" | xargs -I {} cp {} .atom/
  find ~/.atom -maxdepth 1 -type f -name "*.less" | xargs -I {} cp {} .atom/
elif [[ "$OSTYPE" == "darwin"* ]]; then
  find ~/.atom -type f -d 1 -name "*.cson" | grep projects.cson --invert-match | xargs -I {} cp {} .atom/
  find ~/.atom -type f -d 1 -name "*.coffee" | xargs -I {} cp {} .atom/
  find ~/.atom -type f -d 1 -name "*.less" | xargs -I {} cp {} .atom/
fi
