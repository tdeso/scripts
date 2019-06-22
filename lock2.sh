#!/bin/sh

insidecolor=00000000
ringcolor=ffffffff
keyhlcolor=d23c3dff
bshlcolor=d23c3dff
separatorcolor=00000000
insidevercolor=00000000
insidewrongcolor=d23c3dff
ringvercolor=ffffffff
ringwrongcolor=ffffffff
verifcolor=ffffffff
timecolor=ffffffff
datecolor=ffffffff
loginbox=00000066
font="sans-serif"
fontsize="10"
fontcolor=ffffffff
locktext='Type password to unlock...'

scrot "/tmp/lock.png"
ffmpeg -y -i /tmp/lock.png \
	-filter_complex "boxblur=20" -vframes 1 \
	/tmp/lock_blur.png -loglevel quiet

i3lock \
	-t -i "$1" \
	--timepos='x+110:h-70' \
	--datepos='x+43:h-45' \
	--clock --date-align 1 --datestr "Type password to unlock..." \
	--insidecolor=$insidecolor --ringcolor=$ringcolor --line-uses-inside \
	--keyhlcolor=$keyhlcolor --bshlcolor=$bshlcolor --separatorcolor=$separatorcolor \
	--insidevercolor=$insidevercolor --insidewrongcolor=$insidewrongcolor \
	--ringvercolor=$ringvercolor --ringwrongcolor=$ringwrongcolor --indpos='x+280:h-70' \
	--radius=20 --ring-width=4 --veriftext='' --wrongtext='' --{verif,wrong}size=$fontsize --{wrong,verif}color=$fontcolor\
	--verifcolor="$verifcolor" --timecolor="$timecolor" --datecolor="$datecolor" \
	--time-font="$font" --date-font="$font" --layout-font="$font" --verif-font="$font" --wrong-font="$font" \
	--image=/tmp/lock_blur.png &
	--noinputtext='' --force-clock $lockargs &

	#--ringcolor=2f3341ff \
	#--verifcolor=ccccccff \
	#--wrongcolor=ccccccff \
	#--keyhlcolor=4d9de0ff \
	#--insidecolor=15171d00 \
	#--ringvercolor=4d9de0ff \
	#--insidevercolor=15171dff \
	#--ringwrongcolor=ed254eff \
	#--image=/tmp/lock_blur.png \
	#--insidewrongcolor=15171d00 \
	#--clock \
	#--bshlcolor=ed254eff &

while pgrep -x i3lock; do
	[[ 10000 -lt $(xssstate -i) ]] && xset dpms force off;
	sleep 5
done  &>/dev/null
