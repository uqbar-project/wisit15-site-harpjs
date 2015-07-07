#!/bin/bash

echo "Starting deployment"
TEMP_DIRECTORY="/tmp/__temp_static_content"

echo "Compiling site into " ${TEMP_DIRECTORY}
mkdir ${TEMP_DIRECTORY}
harp compile -o ${TEMP_DIRECTORY}

lftp -u ${USER_FTP},${USER_PASS} -v -e 'mirror / ${TEMP_DIRECTORY} -R -e' uqbar-wiki.org

echo "Cleaning up temp files"
rm -Rf ${TEMP_DIRECTORY}

echo "Deployed successfully."
exit 0
