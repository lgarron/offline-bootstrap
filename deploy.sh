#!/bin/bash

MANIFEST_FILE="inc/cache.manifest"

./manifest --update "${MANIFEST_FILE}"

# rsync -avz --exclude .git . username@website.com:/path/to/directory

./manifest --revert "${MANIFEST_FILE}"

echo "Done deploying. Go to http://www.yourwebsite.com/web/path/to/directory/"