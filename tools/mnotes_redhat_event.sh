#!/bin/bash

#
# Purpose of this script is to create a storage folder for event materials and
# mnotes file for my personal notes about an internal company event.
#
#
COMPANY="_REDHAT"

#
# Load Configuration files..
MY_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $MY_PATH/mnotes-config.sh

DAY=$(date +%d)
MONTH=$(date +%m)
YEAR=$(date +%Y)
DATE=$(date +%F)
DAY_NAME=$(LANG=en_us_88591; date +"%A")

read -p "Event name: " event_name
if [ -z "$event_name" ]; then
 event_name="noname"
fi

read -p "Author: " event_author
if [ -z "$event_author" ]; then
 event_name="noname"
fi

read -p "Day [dd] ($DAY): " VALUE
if [ ! -z "$VALUE" ]; then
  DAY="$VALUE"
fi

read -p "Month [mm] ($MONTH): " VALUE
if [ ! -z "$VALUE" ]; then
  MONTH="$VALUE"
fi

read -p "Year [yyyy] ($YEAR): " VALUE
if [ ! -z "$VALUE" ]; then
  YEAR="$VALUE"
fi

DAY_NAME=$(LANG=en_us_88591; date +"%A" -d $YEAR$MONTH$DAY)
DATE="$YEAR-$MONTH-$DAY"

STORAGE_FOLDER="/storage/_COMPANIES/$COMPANY/_EVENTS/$YEAR/$MONTH/$YEAR-$MONTH-$DAY - [$event_name]"
MNOTES_FOLDER="$MNOTES_DIRECTORY/$MNOTES_REPOSITORY_NAME/_COMPANIES/$COMPANY/_EVENTS/$YEAR/$MONTH"
MNOTES_EVENT_FILE="$YEAR-$MONTH-$DAY - [$event_name].md"

mkdir -p "$STORAGE_FOLDER"
mkdir -p "$STORAGE_FOLDER/_PRESENTATION"
mkdir -p "$STORAGE_FOLDER/_SCREENSHOTS"
mkdir -p "$STORAGE_FOLDER/_RECORDING"
mkdir -p "$MNOTES_FOLDER"

OUTPUT="$MNOTES_FOLDER/$MNOTES_EVENT_FILE"

echo "# $event_name" > "$OUTPUT"
echo "Date: $MONTH/$DAY/$YEAR" >> "$OUTPUT"
echo "Author: $event_author" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Resources:" >> "$OUTPUT"
echo "----------" >> "$OUTPUT"
echo "* Presentation" >> "$OUTPUT"
echo "  <link>" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "* Recording" >> "$OUTPUT"
echo "  <link>" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Personal Notes:" >> "$OUTPUT"
echo "---------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Calendar description:" >> "$OUTPUT"
echo "---------------------" >> "$OUTPUT"

#
# Open Storage for files of this event..
nautilus "$STORAGE_FOLDER" &
