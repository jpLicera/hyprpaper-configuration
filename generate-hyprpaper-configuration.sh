#!/bin/bash

set -e

source ".env"

if [[ -z "$WALLPAPER_LOCATION" ]]; then
  echo "Environment variable WALLPAPER_LOCATION is not set."
  exit 1
fi

export WALLPAPER_LOCATION

envsubst < ./hyprpaper.conf.template > ./hyprpaper.conf