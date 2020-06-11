#!/bin/bash

set -euo pipefail
# set -x

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export DOCKER_IMAGE=quay.io/pypa/manylinux1_i686
export PLAT=manylinux1_i686
export PRE_CMD="linux32"

docker pull $DOCKER_IMAGE
exec docker run --rm -e PLAT=$PLAT -v "$dir/..":/io $DOCKER_IMAGE $PRE_CMD /io/tools/build_wheels.sh
