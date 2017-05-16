#!/bin/ksh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

xrandr --auto

#export QTDIR="/usr/lib/qt5"
#export PATH="usr/bin:$QTDIR/bin:$PATH"
#export QT_PLUGIN_PATH="/usr/lib/plugins:/usr/lib/qt5/plugins"
#export QT_INCLUDE_PATH="/usr/include/qt5"
#export QML2_IMPORT_PATH="/usr/lib/qml:/usr/lib/qt5/qml"
#export QML_IMPORT_PATH="$QML2_IMPORT_PATH"
#export KDE_SESSION_VERSION=5
#export KDE_FULL_SESSION=true

xbacklight -set 15
xbanish &

xset -dpms
xset s off

(while xsetroot -name "`acpi`"; do sleep 15; done)&
. $HOME/bin/urxvtd.sh
$HOME/bin/keyboard.sh
#exec dbus-launch --exit-with-session startkde
#exec dbus-launch --exit-with-session dwm
exec dwm
#exec xfce4-session
