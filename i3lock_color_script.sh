#!/bin/sh

scrot "/tmp/lock.png"
ffmpeg -y -i /tmp/lock.png \
	-filter_complex "boxblur=15" -vframes 1 \
	/tmp/lock_blur.png -loglevel quiet

i3lock \
	--ringcolor=2f3341ff \
	--verifcolor=ccccccff \
	--wrongcolor=ccccccff \
	--keyhlcolor=4d9de0ff \
	--insidecolor=15171d00 \
	--ringvercolor=4d9de0ff \
	--insidevercolor=15171dff \
	--ringwrongcolor=ed254eff \
	--image=/tmp/lock_blur.png \
	--insidewrongcolor=15171d00 \
	--bshlcolor=ed254eff &

while pgrep -x i3lock; do
	[[ 10000 -lt $(xssstate -i) ]] && xset dpms force off;
	sleep 5
done  &>/dev/null

# If you want stronger blur I'd recommend doing something like this
# 
# scrot "/tmp/lock.png"
# ffmpeg -y -i /tmp/lock.png \
#	 -filter_complex "boxblur=15" -vframes 1 \
# 	 /tmp/lock_blur.png &>/dev/null
#
# then add
# 
#	 --image=/tmp/lock_blur.png \
#
#to your i3lock arguments as ffmpeg blur is much faster than imagemagick blur.
