#!/bin/sh

DEV=wlp2s0b1
sudo ip l set $DEV up
#iwlist $DEV scan | sed -n 's/\s\+Channel://p' | sort -n | uniq -c
sudo iwlist $DEV scan | grep "SSID\|Channel\|Freq\|Quality"
