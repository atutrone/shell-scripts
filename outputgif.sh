#! /bin/bash

echo "Converting Video file to GIF... script will now run."
sleep 2

start_time=00:00
duration=10

directory="/usr/local/giftmp"
palette="/usr/local/giftmp/palette.png"
filters="fps=15,scale=480:-1:flags=lanczos"

echo "checking to see if giftmp exists... "

if [ ! -d "$directory" ]; then
	echo "creating directory..."
	mkdir -p /usr/local/giftmp
fi

echo "starting ffmpeg..."

sleep 5

ffmpeg -ss $start_time -t $duration -i input.mov -vf "$filters,palettegen" -y $palette

sleep 5

ffmpeg -ss $start_time -t $duration -i input.mov -i $palette -filter_complex "$filters [x];[x][1:v]paletteuse" output.gif

echo "removing palette.png ..." 
rm /usr/local/giftmp/palette.png

echo "removed."

echo "relocating gif..."

mv /usr/local/output.gif ~/Desktop/

echo "done.  Script ending"
