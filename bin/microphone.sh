#!/bin/sh

if [ "$1" = "-t" ]; then
  amixer sset Capture,0 toggle
  exit
fi

if [ "$1" = "-u" ]; then
  MUTE="unmute"
fi

if [ "$1" = "-m" ]; then
  #arecord -f cd -d 0 -D hw:1,0 -vv /dev/null
  #arecord -f cd -c1 -d 0 -D hw:Headset -vv /dev/null
  arecord -f cd -c2 -d 0 -D hw:0,0 -vv /dev/null
  #arecord -f cd -c2 -d 0 -D hw:makemono -vv /dev/null
  exit
fi

amixer sset Capture,0 63% cap
amixer sset Capture,1 0% uncap
amixer sset 'Digital',0 80% unmute
amixer sset Mic,0 90% cap ${MUTE:-"mute"}
amixer sset Mic,1 90% cap mute
amixer sset 'Mic Boost',0 1
if [ "$1" = "-i" ]; then
  amixer sset 'Input Source',0 'Internal Mic'
else
  amixer sset 'Input Source',0 'Mic'
fi
amixer sset 'Input Source',1 'Mix'

exit

echo stare strieborne cinske
amixer sset Capture,0 70% cap
amixer sset Capture,1 0% uncap
amixer sset 'Digital',0 80% unmute
amixer sset Mic,0 90% cap mute
amixer sset Mic,1 90% cap mute
amixer sset 'Mic Boost',0 0
amixer sset 'Input Source',0 'Mic'
exit
