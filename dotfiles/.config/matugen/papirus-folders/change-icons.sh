#!/bin/bash

# Papirus-supported colors (name → reference hex for matching)
declare -A colors=(
  [blue]="#5294E2"
  [green]="#87B158"
  [red]="#E25252"
  [yellow]="#E5C07B"
  [orange]="#E58A52"
  [pink]="#E2529D"
  [violet]="#A675D1"
  [teal]="#52E5C4"
  [cyan]="#52C7E5"
  [grey]="#8A8A8A"
)

# Read hex color from matugen output
hex=$(<~/.config/matugen/papirus-folders/folder-color.txt)

# Convert HEX → RGB
hex_to_rgb() {
  local hex=$1
  local r=$((16#${hex:1:2}))
  local g=$((16#${hex:3:2}))
  local b=$((16#${hex:5:2}))
  echo "$r $g $b"
}

read r1 g1 b1 <<< "$(hex_to_rgb "$hex")"

# Find closest Papirus color
min_distance=1000000
closest_color="blue"

for name in "${!colors[@]}"; do
  read r2 g2 b2 <<< "$(hex_to_rgb "${colors[$name]}")"

  distance=$(( 
    (r1 - r2)*(r1 - r2) +
    (g1 - g2)*(g1 - g2) +
    (b1 - b2)*(b1 - b2)
  ))

  if (( distance < min_distance )); then
    min_distance=$distance
    closest_color=$name
  fi
done

# Safety check (extra protection)
valid_colors=(blue green red yellow orange pink violet teal cyan grey)

if [[ ! " ${valid_colors[@]} " =~ " ${closest_color} " ]]; then
  closest_color="blue"
fi

echo "Closest Papirus color to $hex is: $closest_color"

# Apply folder color
~/.local/share/icons/papirus-folders.sh -C "$closest_color" -t Papirus-Dark