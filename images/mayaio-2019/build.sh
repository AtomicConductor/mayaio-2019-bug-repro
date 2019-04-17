#!/bin/bash

set -o errexit # exit upon any non-zero return status
set -o xtrace  # print each command executed
set -o nounset # return non-zero if an unset variable is used

# -- THIS FILE MUST BE EXECUTED FROM THE ROOT OF THE GIT/PROJECT DIRECTORY !! ---

docker build \
  --tag 'conductor-mayaio-2019' \
  --build-arg MAYAIO_2019_INSTALLER='installers/Autodesk_MayaIO_2019_Linux_64bit.run' \
  --build-arg AUTODESK_LICENSE_SERVER="$1" \
  --file images/mayaio-2019/Dockerfile \
  .
