#!/bin/bash

set -euo pipefail
set -x

if [ -z "${encrypted_cda11dbc1ebd_key:-}" ]; then
    echo "encrypted key missing: skipping upload" >&2
    exit 0
fi

# Set up files required for upload
openssl aes-256-cbc \
    -K $encrypted_cda11dbc1ebd_key -iv $encrypted_cda11dbc1ebd_iv \
    -in data/id_rsa-setproctitle-upload.enc \
    -out data/id_rsa-setproctitle-upload -d

chmod 600 data/{known_hosts,id_rsa-setproctitle-upload,ssh_config}

# Print sha1 checksum in portable format. You can copy the output of this
# command and paste it into `shasum -c` to verify packages downloaded locally.
(cd dist && shasum -p -a 1 */*)

rsync -avr -e "ssh -F data/ssh_config" dist/ upload:
