#! /bin/bash -e

#
# Update `hotdog` file.
#
# It is important to execute this script every day to have updated template
# for today's notes - we call them `hotdog`. Ideally copy this file to
# $HOME/.local/bin/mnotes.sh and execute this file from crontab or during
# the start of you working environmnet. It is not recommended to use .bashrc,
# use your environment specific settings in (GNOME, i3, etc).
#

# ACTION REQUIRED: Update these variables with your local environemnt..
MNOTES_REPOSITORY_NAME="mnotes"
MNOTES_GIT_SERVER=""
MNOTES_DIRECTORY="/var/git/$MNOTES_GIT_SERVER/$USER"

#
# Basic checks..
#
if [ -z $MNOTES_GIT_SERVER ]; then
  echo "You need to update the mnotes script with your local environemnt settings."
  echo "You need to set name of your REPOSITORY_NAME, GIT_SERVER and DIRECTORY."
  exit 1
fi

if [ ! -d "$MNOTES_DIRECTORY" ]; then
  echo "Directory for mnotes does not exists!"
  echo "MNOTES_DIRECTORY: $MNOTES_DIRECTORY"
  exit 1
fi

#
DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=`date +%Y`
DATE=`date +%F`
DAY_NAME=$(LANG=en_us_88591; date +"%A")

REPOSITORY_FOLDER="$MNOTES_DIRECTORY/$MNOTES_REPOSITORY_NAME"

#
# HOTDOG - Today's notes..
#
HOTDOG_FOLDER="$REPOSITORY_FOLDER/_HOTDOG/$YEAR/$MONTH"
HOTDOG_FILE="$HOTDOG_FOLDER/index-$DATE-$DAY_NAME.md"

# Let's make today's hotdog great again..
SUBLIME_FAVORITES_FILE="$HOME/.config/sublime-text/Packages/User/favorites.txt"
sed -i 's,^_HOTDOG.*,_HOTDOG|'"$HOTDOG_FILE"',g' "$SUBLIME_FAVORITES_FILE"

# If directory for hotdog does not exist..
if [ ! -e "$HOTDOG_FOLDER" ]; then
  mkdir -p "$HOTDOG_FOLDER"
fi

# Create HOTDOG_FILE for today's notes (hotdog) if it does not exists yet..
if [ ! -e "$HOTDOG_FILE" ]; then
  cp "$REPOSITORY_FOLDER/templates/_hotdog.md" "$HOTDOG_FILE"
  sed -i "s/__DATE__/$MONTH\/$DAY\/$YEAR/g" "$HOTDOG_FILE"
  sed -i "s/__DAYNAME__/$DAY_NAME/g" "$HOTDOG_FILE"
fi

## If window is opened, then activate it..
#if wmctrl -l | grep -q Sublime; then
#  wmctrl -a Sublime
#  exit
#fi
