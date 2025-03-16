#!/bin/bash

#~/.config/hypr/wallpaper_test2.sh

# Path to wallpapers
wallpaperDirectory="$HOME/Pictures/Wallpapers"

# Array with all image files of the wallpaper directory
wallpapers=("$wallpaperDirectory"/*)

#echo "${wallpapers[@]}"
#echo "${#wallpapers[@]}"

#lengthOfArrayMinusOne=$(( ${#wallpapers[@]} - 1 ))
#lengthOfArray=${#wallpapers[@]}
#echo "LENGTH: $lengthOfArray"
#selectedWallpaperNumber=$((0 + $RANDOM % $lengthOfArray))
#echo "RANDOM: $selectedWallpaperNumber"

failCounter=0

while true; do

	echo "Fail Counter: " $failCounter
	lengthOfArray=${#wallpapers[@]}
	echo "length of array before refresh: $lengthOfArray"
	if [[ "$lengthOfArray" == "1" ]]; then
		echo "not balling anymore, renewing array"
		wallpapers=("$wallpaperDirectory"/*)
		else echo "still ballin"
	fi

	echo "lengthOfArray + limit of failCounter = $(( lengthOfArray + 20 ))"

	if (( failCounter > (( lengthOfArray + 20 )) )); then
		echo "Fail Counter exceeded, renewing array"
		wallpapers=("$wallpaperDirectory"/*)
	fi

	lengthOfArray=${#wallpapers[@]}
	echo "length of array after refresh: ${lengthOfArray}"
	echo "array: ${wallpapers[@]}"
	selectedWallpaperNumber=$((0 + $RANDOM % $lengthOfArray))
	echo "selected Wallpaper Number: $((selectedWallpaperNumber))"
	selectedWallpaper="${wallpapers[$(($selectedWallpaperNumber))]}"	
	echo "ausgewählter Dateipfad:" $selectedWallpaper "."

	if [[ ${selectedWallpaper} != "" ]]; then
		echo "setting new background"
		swww img "$selectedWallpaper" --transition-type random --transition-step 90 --transition-fps 60 --transition-duration 3
		failCounter=0
		sleep 10m
		
	else 
		echo "der zwonkelt dich"
		failCounter=$(( failCounter + 1 ))	
	fi

	echo "deleting previously selected wallpaper from array"
	for i in "${!wallpapers[@]}"; do
		if [[ ${wallpapers[i]} == $selectedWallpaper ]]; then
			unset "wallpapers[i]"
		fi
	done

	failCounter=$(( failCounter + 1 ))
	
	echo -e "completed one cycle\n "

	sleep 1s
done
