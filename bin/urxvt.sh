#!/bin/sh

# Put following into ~/.xsession
#XRES=`xdpyinfo | sed -n 's/\s\+dimensions:\s\+\([0-9]\+x[0-9]\+\)\s.*/\1/p'`
#export X_resx=${XRES%x*}
#export X_resy=${XRES#*x}

##RANDX=$((($RANDOM%$X_resx)-616))
#RANDX=$((($X_resx-616)/2))
##RANDY=$((($RANDOM%$X_resy)-416))
#RANDY=$((($X_resy-416)/2))

#urxvtc -geometry +$RANDX+$RANDY "$@"
. ~/.config/locale-my
#urxvtc "$@"
exec urxvt "$@"
