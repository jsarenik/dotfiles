#!/bin/sh

# Put following into ~/.xsession
#XRES=`xdpyinfo | sed -n 's/\s\+dimensions:\s\+\([0-9]\+x[0-9]\+\)\s.*/\1/p'`
#export X_resx=${XRES%x*}
#export X_resy=${XRES#*x}

RANDX=$((RANDOM%(X_resx-650)))
RANDY=$((RANDOM%(X_resy-570)))

#exec urxvtc -geometry 80x24+$RANDX+$RANDY "$@"
exec st -f -*-terminus-*-*-*-*-24-*-*-*-*-*-*-* -g 80x24+$RANDX+$RANDY "$@"
#exec urxvtc "$@"
