#!/bin/bash

set -euo pipefail
# set -x

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export DOCKER_IMAGE=quay.io/pypa/manylinux1_x86_64
export PLAT=manylinux1_x86_64
export PRE_CMD=""

docker pull $DOCKER_IMAGE
exec docker run --rm -e PLAT=$PLAT -v "$dir/..":/io $DOCKER_IMAGE $PRE_CMD /io/tools/build_wheels.sh
