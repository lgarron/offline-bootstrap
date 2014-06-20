#!/bin/bash


# This script modifies the manifest file to include a unique timestamp on every upload (so that browsers will look for a new version). In case of failure, we end up with a modified manifest file that will be restored to normal on next success.
MANIFEST_FILE="inc/cache.manifest"

# Set this to ".bak" if you want to protect your cache manifest in case `sed` fails.
BACKUP_EXTENSION=".bak"

# Call this before deploying to your web server.
function pre_deploy {
  DATE="$(date)"
  echo "[CACHE MANIFEST] Creating unique version by updating date to: ${DATE}"
  sed -i "${BACKUP_EXTENSION}" "s/Uploaded on .*/Uploaded on ${DATE}/" "${MANIFEST_FILE}"
}

# Call this after deploying to your web server to restore the manifest file.
function post_deploy {
  echo "[CACHE MANIFEST] Reverting."
  sed -i "${BACKUP_EXTENSION}" "s/Uploaded on .*/Uploaded on [DATE]/" "${MANIFEST_FILE}"
}



pre_deploy

# rsync -avz --exclude .git . username@website.com:/path/to/directory

post_deploy

echo "Done deploying. Go to http://www.yourwebsite.com/web/path/to/directory/"