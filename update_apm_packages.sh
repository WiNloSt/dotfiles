#!/usr/bin/env bash

apm list -ib > .atom/packages.list

# copy all config files
find ~/.atom -type f -name "*.cson" -d 1 | xargs -I {} cp {} .atom/
find ~/.atom -type f -name "*.coffee" -d 1 | xargs -I {} cp {} .atom/
find ~/.atom -type f -name "*.less" -d 1 | xargs -I {} cp {} .atom/

# delete projecct manager config since it should be machine specific
rm .atom/projects.cson
