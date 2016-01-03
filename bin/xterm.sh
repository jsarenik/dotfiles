#!/bin/sh

#   Add following to your .xsessionrc executed
###
# RESBOTH=`xwininfo -root | sed -nE 's/  (Width|Height): //p'`
# RESBOTH=`xwininfo -root | sed -nE '/(Width|Height)/{s/\([0-9]\+\)/\1/p'`
# RESBOTH=`xwininfo -root | sed -nE '/  (Width|Height): /{s///p}'`

. $HOME/.config/locale-my
#resx=1280; resy=1024
#resx=${resx:-1024}; resy=${resy:-768}

# X-Term width with your font and other settings
width=816
height=516

x=$(($RANDOM%($resx-$width)))
y=$(($RANDOM%($resy-$height)))
exec xterm -geometry 80x25+$x+$y "$@"
