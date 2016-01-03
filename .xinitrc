#!/bin/sh -x

cd $HOME
set -x

# . $HOME/.bash_profile - xinit is run from login shell, so do not source again
. $HOME/bin/urxvtd.sh

# Enable this for non-reparenting window managers
export _JAVA_AWT_WM_NONREPARENTING=1

# IBUS
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
#ibus-daemon --xim -d

xrdb -load $HOME/.Xdefaults

. $HOME/bin/keyboard.sh
xset +fp /usr/share/fonts/local
xset fp rehash
#xhost +
xset -b
#syndaemon -i 2 -R -d
#xbacklight -set 50

xautolock -locker xlock.sh -time 5 &
/usr/local/bin/xwrits +top +breakclock +mouse +lock &

xsetroot -solid black
xsetroot -cursor_name left_ptr
#clipit --daemon --no-icon &

battery-mon.sh &

# https://bbs.archlinux.org/viewtopic.php?id=189499
#sudo sh -c "echo 50 > /sys/devices/system/cpu/intel_pstate/max_perf_pct"

#/usr/local/bin/dwmstatus &
#exec dbus-launch --exit-with-session dwm
exec dwm
#exec /usr/local/bin/dwm
#exec /usr/bin/goomwwm -modkey Mod1
#exec /usr/local/bin/cwm
#exec /usr/bin/awesome
