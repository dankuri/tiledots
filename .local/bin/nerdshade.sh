#!/usr/bin/env bash

if ! command -v hyprsunset >/dev/null 2>&1; then
    echo "hyprsunset not available"
    exit 1
fi

hyprctl keyword exec hyprsunset

if ! command -v nerdshade >/dev/null 2>&1; then
    echo "nerdshade not available"
    exit 1
fi

raw=$(curl ipinfo.io/loc)
IFS=',' read -r lat lon <<< "$raw"

hyprctl keyword exec "nerdshade -loop -latitude $lat -longitude $lon"
