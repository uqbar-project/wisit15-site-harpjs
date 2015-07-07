#!/bin/bash

set -e

echo "Starting deployment"
TEMP_DIRECTORY="/tmp/__temp_static_content"

echo "Compiling site into " ${TEMP_DIRECTORY}
mkdir -p ${TEMP_DIRECTORY}
harp compile -o ${TEMP_DIRECTORY}

echo "'mirror -R -e -v / ${TEMP_DIRECTORY}'"
lftp -u ${USER_FTP},${USER_PASS} -e "set ftp:ssl-allow no; set ftp:charset utf8; mirror -R -e -v --no-symlinks ${TEMP_DIRECTORY} /; quit"  uqbar-wiki.org

echo "Cleaning up temp files"
rm -Rf ${TEMP_DIRECTORY}

echo "Deployed successfully."
exit 0
