#!/bin/bash

set -euo pipefail
# set -x

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Find the version
export VERSION=$(grep -e ^VERSION setup.py | sed 's/.*"\(.*\)"/\1/')
# A gratuitous comment to fix broken vim syntax file: '")
export DISTDIR="$dir/../dist/setproctitle-$VERSION"

# Build the source package
python setup.py sdist -d "$DISTDIR"

# make sure to test what was installed
cd /

# install and test
sudo `which pip` install --no-index -f "$DISTDIR" setproctitle
sudo `which pip` install pytest
python -c "import setproctitle; assert setproctitle.__version__ == '${VERSION}'"
pytest --color=yes -v "$dir/../tests" -m "not embedded"
