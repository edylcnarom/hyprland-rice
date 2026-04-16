#!/bin/bash

# Wallpaper directory
wp_dir="/home/moran/Projects/hyprland-rice/dotfiles/Hyprland-Wallpapers"

# Current wallpaper
#'awww query' to find current active wallpaper
current_wp=$(awww query | awk '{print $NF}')

# Random wallpaper
new_wp=$(find "$wp_dir" -type f | shuf -n 1)

# If picks current_wp, search new one
while [ "$new_wp" == "$current_wp" ]; do
    new_wp=$(find "$wp_dir" -type f | shuf -n 1)
done

# Random Transition Position
X_POS="0.$(printf "%02d" $((RANDOM % 100)))"
Y_POS="0.$(printf "%02d" $((RANDOM % 100)))"

# 5. Change Wallpaper

awww img "$new_wp" --transition-type grow --transition-fps 60 --transition-duration 1.5 --transition-pos "$X_POS,$Y_POS"

