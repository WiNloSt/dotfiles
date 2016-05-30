#!/usr/bin/env bash

apm list -ib > .atom/packages.list

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
