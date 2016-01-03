#!/bin/sh

PATH=/sbin:/usr/sbin:$PATH

{
xautolock -locknow
sleep 1
pgrep cmus && cmus-remote -s
} 2>/dev/null
sudo sh -c "echo mem > /sys/power/state"
#sudo pm-suspend

{
sleep 2
sudo alsactl restore
pgrep cmus && cmus-remote -p
} 2>/dev/null
