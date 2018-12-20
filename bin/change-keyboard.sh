#!/bin/sh

while true
do
if
  setxkbmap -query | grep -q '^layout:     dvorak'
then
  keyboard.sh il
else
  keyboard.sh
fi
read key
done
