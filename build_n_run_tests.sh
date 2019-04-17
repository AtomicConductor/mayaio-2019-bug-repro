#!/bin/bash

set -o errexit # exit upon any non-zero return status
set -o xtrace  # print each command executed
set -o nounset # return non-zero if an unset variable is used

# -- THIS FILE MUST BE EXECUTED FROM THE ROOT OF THE GIT/PROJECT DIRECTORY !! ---

# Build base image (centos 7.5) and MtoA 3.x
images/base-image/build.sh

# Build maya 2019 image
echo "Building Maya 2019 container image..."
images/maya-2019/build.sh
echo "Maya 2019 image build complete!..."

# Build mayaio 2019 image
echo "Building MayaIO 2019 container image..."
images/mayaio-2019/build.sh "$1" # provide a host license server address here, e.g. "42.052.12.200" 
echo "MayaIO 2019 image build complete!..."

# Run test render for Maya 2019 using MtoA 3.x
echo "Running Maya 2019 render test..."
tests/maya-2019/run_test.sh

 # Run render test for Maya-IO 2019 MtoA 3.x
echo "Running MayaIO 2019 render test..."
tests/mayaio-2019/run_test.sh