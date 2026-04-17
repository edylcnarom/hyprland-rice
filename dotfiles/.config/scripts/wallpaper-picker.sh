#!/bin/bash

# === CONFIG ===
WALLPAPER_DIR="$HOME/Projects/hyprland-rice/dotfiles/Hyprland-Wallpapers"
SYMLINK_PATH="$HOME/Projects/hyprland-rice/dotfiles/.config/hypr/current_wallpaper"

cd "$WALLPAPER_DIR" || exit 1

# === handle spaces name
IFS=$'\n'

# === ICON-PREVIEW SELECTION WITH ROFI, SORTED BY NEWEST ===
SELECTED_WALL=$(for a in $(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null); do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -p "")
[ -z "$SELECTED_WALL" ] && exit 1
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

# Random Transition Position
X_POS="0.$(printf "%02d" $((RANDOM % 100)))"
Y_POS="0.$(printf "%02d" $((RANDOM % 100)))"

# === SET WALLPAPER ===
awww img "$SELECTED_PATH" --transition-type grow --transition-fps 60 --transition-duration 1.5 --transition-pos "$X_POS,$Y_POS"

# Generate Matugen Colors
matugen image "$SELECTED_PATH" --prefer saturation

# === CREATE SYMLINK ===
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"
