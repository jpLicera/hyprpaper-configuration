#!/usr/bin/env bash

# Given the directory from which the hyprpaper configuration will be read, generates
# a symbolic link in that directory, pointing to the `hyprpaper.conf` file.
# This script would normally only be executed once to create the symbolic link,
# and subsequent changes made to the configuration file can be "applied" by invoking
# `systemctl --user restart hyprpaper.service`, if not automatically detected.

set -e

source ".env"

if [[ -z "$HYPRPAPER_CONFIG_LOCATION" ]]; then
  echo "Environment variable HYPRPAPER_CONFIG_DIRECTORY is not set"
  exit 1
fi

readonly FILE_NAME="hyprpaper.conf"

readonly CONFIG_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

readonly LINK_ORIGIN="$CONFIG_LOCATION/$FILE_NAME"

if [ ! -e "$LINK_ORIGIN" ]; then
  echo "Configuration file does not exist. Aborting."
  exit 1
fi

readonly LINK_DESTINATION="$HYPRPAPER_CONFIG_LOCATION/$FILE_NAME"

rm $LINK_DESTINATION

ln -s "$LINK_ORIGIN" "$LINK_DESTINATION"

systemctl --user restart hyprpaper.service
