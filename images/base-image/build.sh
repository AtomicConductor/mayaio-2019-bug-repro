#!/bin/bash

set -o errexit # exit upon any non-zero return status
set -o xtrace  # print each command executed
set -o nounset # return non-zero if an unset variable is used

# -- THIS FILE MUST BE EXECUTED FROM THE ROOT OF THE GIT/PROJECT DIRECTORY !! --- 

docker build \
  --tag 'conductor-base' \
  --build-arg MTOA_INSTALLER='installers/MtoA-3.2.0.2-linux-2019.run' \
  --file 'images/base-image/Dockerfile' \
  .
