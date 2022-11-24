#! /bin/bash

#
# Usage in script:
# ----------------
# # Load Configuration files..
# MY_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
# . $MY_PATH/config.sh
#

# ACTION REQUIRED: Update these variables with your local environemnt..
MNOTES_REPOSITORY_NAME="mnotes"
MNOTES_GIT_SERVER=""
MNOTES_DIRECTORY="/var/git/$MNOTES_GIT_SERVER/$USER"
