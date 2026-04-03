#!/bin/sh

## START WAYBAR

# Quit running waybars
killall waybar

# Load Config based on user

if [[ $USER = "moran" ]]
then
    waybar -c ~/dotfiles/waybar/config.jsonc & -s ~/dotfiles/waybar/style.css
else
    waybar &
fi
