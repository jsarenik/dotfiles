#!/bin/sh

export RXVT_SOCKET="$HOME/.rxvt-unicode-$HOSTNAME"
XRES=`xdpyinfo | sed -n 's/\s\+dimensions:\s\+\([0-9]\+x[0-9]\+\)\s.*/\1/p'`
export X_resx=${XRES%x*}
export X_resy=${XRES#*x}

pgrep ^urxvtd$ > /dev/null \
  && pkill ^urxvtd$ \
  && rm $RXVT_SOCKET
urxvtd -q -o -f
