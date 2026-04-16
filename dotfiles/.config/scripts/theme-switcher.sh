#!/bin/bash

# Wallpaper directory
WALLPAPER_DIR="$HOME/Projects/hyprland-rice/dotfiles/Hyprland-Wallpapers"
SYMLINK_PATH="$HOME/Projects/hyprland-rice/dotfiles/.config/hypr/current_wallpaper"


# Current wallpaper
#'awww query' to find current active wallpaper
CURRENT_WALLPAPER="$HOME/Projects/hyprland-rice/dotfiles/.config/hypr/current_wallpaper/"

# Random wallpaper
NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# If picks current_wp, search new one
while [ "$NEW_WALLPAPER" == "$CURRENT_WALLPAPER" ]; do
    NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
done

# Random Transition Position
X_POS="0.$(printf "%02d" $((RANDOM % 100)))"
Y_POS="0.$(printf "%02d" $((RANDOM % 100)))"

## CURSOR_POS=$(hyprctl cursorpos | sed 's/ //g')

# Change Wallpaper

awww img "$NEW_WALLPAPER" --transition-type grow --transition-fps 60 --transition-duration 1.5 --transition-pos "$X_POS,$Y_POS"


# Create Sym-Link
ln -sf "$NEW_WALLPAPER" "$SYMLINK_PATH"

# Generate Matugen Colors
matugen image "$NEW_WALLPAPER" --prefer saturation