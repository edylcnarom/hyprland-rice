#!/bin/sh

## START WAYBAR

# Quit running waybars
killall waybar

# Load Config based on user

if [[ $USER = "moran" ]]
then
    waybar -c ~/.config/waybar/config.jsonc & -s ~/.config/waybar/style.css
else
    waybar &
fi
