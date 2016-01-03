#!/bin/sh

setxkbmap ${1:-'dvorak'}

setxkbmap -option ""
xmodmap - <<EOF
! for help, see $ xmodmap -grammar

!in /etc/X11/xorg.conf.d/20-keyboard.conf
! or by running setxkbmap -option "ctrl:nocaps"
remove Lock = Caps_Lock
keysym Caps_Lock = Control_L
add Control = Control_L

! MacBook keys - Alt instead of Command, Right Command = Compose
clear Mod4
clear Mod1
keycode 133 = Super_R
!keycode 134 = Super_L
keysym Super_R = Multi_key
add Mod1 = Alt_L Super_L

! Natural two-finger scrolling
pointer = 1 2 3 5 4 7 6 8 9 10 11 12 13
!pointer = 1 2 3 5 4 7 6 8 9 10 11 12
EOF

#! Normal right Alt Compose
xmodmap -e 'keysym Alt_R = Multi_key'


#setxkbmap -option "ctrl:nocaps"
#setxkbmap -option "compose:ralt"
#setxkbmap -option "compose:rctrl"
#setxkbmap -option "grp:alts_toggle"
#setxkbmap -option "grp_led:scroll"

setxkbmap -query

# ...
# Keyboard Control:
#   auto repeat:  on    key click percent:  0    LED mask:  00000000
#   XKB indicators:
#     00: Caps Lock:   off    01: Num Lock:    off    02: Scroll Lock: off
#     03: Compose:     off    04: Kana:        off    05: Sleep:       off
# ...

CAPSTATE=`xset -q | grep -Eo "[0-9]+: Caps Lock:\s+\S+" | awk '{print $4}'`
test "$CAPSTATE" = "on" && xdotool key Caps_Lock
