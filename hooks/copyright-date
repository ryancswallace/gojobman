#!/usr/bin/sh

# Updates the ending year of the copyright starting date range
# to the current year across all files

set -e

# required commands
DATE=date
GREP=grep
XARGS=xargs
SED=sed

# check if required commands available
# if not available, exit with success return code
# but print warning message to stderr
for CMD in $DATE $GREP $XARGS $SED
do
    if ! command -v "$CMD" &> /dev/null
    then
        >&2 echo "warning: command "$CMD" required for copyright date hook not found. Aborting hook."
        exit
    fi
done

# replace all instances of © 2021-[0-9]{4} with © 2021-$CURRENT_YEAR
START_YEAR=2021
CURRENT_YEAR=$("$DATE" '+%Y')
"$GREP" -rl --exclude-dir=.git "© $START_YEAR-" . | "$XARGS" "$SED" -i "s/© $START_YEAR-[0-9]\{4\}/© $START_YEAR-$CURRENT_YEAR/g"