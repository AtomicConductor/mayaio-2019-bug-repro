#!/bin/bash
set -o errexit # exit upon any non-zero return status
set -o xtrace  # print each command executed
set -o nounset # return non-zero if an unset variable is used

# -- THIS FILE MUST BE EXECUTED FROM THE GIT REPOSITORY ROOT DIRECTORY !! --- 

echo "Fetching latest conductor-maya-2019 image..."
image_id=$(docker images --digests --no-trunc -q conductor-maya-2019:latest)

echo "image id: ${image_id}"

docker run \
   --rm \
   --volume="$(pwd)/tests/content:/tmp/content:ro" \
   --env-file="$(pwd)/tests/maya-2019/env" \
   $image_id \
   bash -c 'Render \
    -s 1 -e 1 \
    -rd /tmp/output \
    -proj /tmp/content \
    /tmp/content/maya2019-mtoa3.2.0.1-basic_01.ma'

