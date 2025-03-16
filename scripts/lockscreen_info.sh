#!/bin/bash

#~/.config/hypr/lockscreen_info.sh

# Define non-charging battery icons
battery_icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

# Define charging battery icons
battery_icons_charging=("󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")

# Get current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get battery status (charging / not charging)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
#battery_status="Charging"

# Get index number for icon array
index=$((battery_percentage / 10))

# Debug echo for battery_status
#echo "$battery_status"

# Check if battery is charging and select battery_icon accordingly
if [ "$battery_status" == "Charging" ]; then

	battery_icon=${battery_icons_charging[index]}

	else battery_icon=${battery_icons[index]}

fi

echo "$battery_icon $battery_percentage%"
