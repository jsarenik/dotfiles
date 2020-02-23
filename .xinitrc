#!/bin/sh

XRES=`xdpyinfo | sed -n 's/\s\+dimensions:\s\+\([0-9]\+x[0-9]\+\)\s.*/\1/p'`
export X_resx=${XRES%x*}
export X_resy=${XRES#*x}

#xrandr --auto
xhost +

#xbacklight -set 15
xbanish &

#syndaemon -i 2 -d
#. $HOME/bin/urxvtd.sh
$HOME/bin/mouse.sh
$HOME/bin/keyboard.sh
exec dwm
#urxvtc.sh
#exec awesome
