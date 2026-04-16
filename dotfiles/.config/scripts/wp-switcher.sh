#!/bin/bash

# Wallpaper directory
wp_dir="$HOME/Projects/hyprland-rice/dotfiles/Hyprland-Wallpapers"
symlink_path="$HOME/Projects/hyprland-rice/dotfiles/.config/hypr/current-wp/current_wp"


# Current wallpaper
#'awww query' to find current active wallpaper
current_wp="$HOME/Projects/hyprland-rice/dotfiles/.config/hypr/current-wp/current_wp"

# Random wallpaper
new_wp=$(find "$wp_dir" -type f | shuf -n 1)

# If picks current_wp, search new one
while [ "$new_wp" == "$current_wp" ]; do
    new_wp=$(find "$wp_dir" -type f | shuf -n 1)
done

# Random Transition Position
X_POS="0.$(printf "%02d" $((RANDOM % 100)))"
Y_POS="0.$(printf "%02d" $((RANDOM % 100)))"

## CURSOR_POS=$(hyprctl cursorpos | sed 's/ //g')

# Change Wallpaper

awww img "$new_wp" --transition-type grow --transition-fps 60 --transition-duration 1.5 --transition-pos "$X_POS,$Y_POS"


# Create Sym-Link
ln -sf "$new_wp" "$symlink_path"