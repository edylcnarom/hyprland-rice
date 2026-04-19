#!/bin/bash

# Configuration
COLOR_FILE="$HOME/.config/matugen/papirus-folders/folder-color.txt"
ICON_SCRIPT="$HOME/.local/share/icons/papirus-folders.sh"
ICON_THEME="$HOME/.local/share/icons/Papirus-Dark"

# Standard Papirus keys (Updated for compatibility)
declare -A colors=(
  [blue]="#89B4FA"
  [pink]="#F2CDCD"      # Flamingo
  [green]="#A6E3A1"
  [indigo]="#B4BEFE"    # Lavender -> Papirus Indigo
  [maroon]="#EBA0AC"
  [violet]="#CBA6F7"    # Mauve
  [orange]="#FAB387"    # Peach
  [magenta]="#F5C2E7"   # Pink
  [red]="#F38BA8"
  [grey]="#F5E0DC"      # Rosewater
  [cyan]="#74C7EC"      # Sapphire
  [sky]="#89DCEB"
  [teal]="#94E2D5"
  [yellow]="#F9E2AF"
)

if [[ ! -f "$COLOR_FILE" ]]; then
    exit 1
fi

hex=$(cat "$COLOR_FILE")

hex_to_rgb() {
  local h=${1#\#}
  echo "$((16#${h:0:2})) $((16#${h:2:2})) $((16#${h:4:2}))"
}

read r1 g1 b1 <<< "$(hex_to_rgb "$hex")"

min_distance=1000000
closest_color=""

for name in "${!colors[@]}"; do
  read r2 g2 b2 <<< "$(hex_to_rgb "${colors[$name]}")"
  distance=$(( (r1 - r2)**2 + (g1 - g2)**2 + (b1 - b2)**2 ))
  
  if (( distance < min_distance )); then
    min_distance=$distance
    closest_color=$name
  fi
done

# --- THE VALIDATION CHECK ---
# Get a list of actual supported colors from your script
SUPPORTED_COLORS=$("$ICON_SCRIPT" -l -t "$ICON_THEME")

if echo "$SUPPORTED_COLORS" | grep -qw "$closest_color"; then
    FINAL_COLOR="$closest_color"
else
    # Fallback: if 'indigo' is missing, try 'bluegrey' or 'blue'
    if echo "$SUPPORTED_COLORS" | grep -qw "bluegrey"; then
        FINAL_COLOR="bluegrey"
    else
        FINAL_COLOR="blue"
    fi
fi

echo "Applying: $FINAL_COLOR (Matched from $hex)"
"$ICON_SCRIPT" -C "$FINAL_COLOR" -t "$ICON_THEME"