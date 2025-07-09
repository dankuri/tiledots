#!/usr/bin/env bash

if ! command -v wlsunset >/dev/null 2>&1; then
    echo "wlsunset not available"
    exit 1
fi

turn_on() {
    raw=$(curl ipinfo.io/loc)
    IFS=',' read -r lat lon <<< "$raw"

    wlsunset -l $lat -L $lon -t 4500 -T 6500 & disown
}

case "$1" in
    "off")
        pkill wlsunset
        ;;
    "on")
        turn_on
        ;;
    "toggle")
        if pgrep -x "wlsunset" > /dev/null; then
            pkill wlsunset
        else
            turn_on
        fi
        ;;
    "waybar-check")
        if pgrep -x "wlsunset" > /dev/null; then
            printf '{"class":"on","alt":"on"}'
        else
            printf '{"class":"off","alt":"off"}'
        fi
        ;;
esac
