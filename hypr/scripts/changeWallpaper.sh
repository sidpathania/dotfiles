#!/bin/bash

# Path to wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpaper"
CACHE_FILE="$HOME/.cache/current_wallpaper"

# Pick a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | shuf -n 1)

echo $WALLPAPER

# echo "$WALLPAPER"
# Save selected wallpaper
ln -sf "$WALLPAPER" "$CACHE_FILE"

# Set wallpaper with hyprpaper
hyprctl hyprpaper reload ,"$WALLPAPER"

# # Set idle wallpaper in hypridle config
# sed -i "s|^.*wallpaper=.*|wallpaper=$WALLPAPER|" ~/.config/hypr/hypridle.conf

# Update pywal colors
wal -i "$WALLPAPER"

~/.config/waybar/launch.sh &

# Restart wallpaper timer
pkill -f wallpaperTimer.sh
~/.config/hypr/scripts/wallpaperTimer.sh &