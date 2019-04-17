#!/bin/bash

set -o errexit # exit upon any non-zero return status
set -o xtrace  # print each command executed
set -o nounset # return non-zero if an unset variable is used

# -- THIS FILE MUST BE EXECUTED FROM THE ROOT OF THE GIT/PROJECT DIRECTORY !! ---

docker build \
  --tag 'conductor-maya-2019' \
  --build-arg MAYA_2019_INSTALLER='installers/Autodesk_Maya_2019_Linux_64bit.tgz' \
  --file images/maya-2019/Dockerfile \
  .
