#!/usr/bin/env bash

file=$1
rec_type=$2 # regular or replay

filename=$(basename $file)

hypr_window=$(hyprctl activewindow -j)
dir=$(echo $hypr_window | jq -r '.class' | tr -d "[:space:]")
title=$(echo $hypr_window | jq -r '.title' | tr -d "[:space:]")

if echo $dir | rg -q 'steam_app'; then
    dir=$title
fi

if [ $rec_type = "replay" ]; then
    mkdir -p "$HOME/Videos/replays/$dir"
    filename=$(echo $filename | sed "s/Replay/$title/")
    mv "$file" "$HOME/Videos/replays/$dir/$filename"
else 
    mkdir -p "$HOME/Videos/recordings/$dir"
    filename=$(echo $filename | sed "s/Video/$title/")
    mv "$file" "$HOME/Videos/recordings/$dir/$filename"
fi
