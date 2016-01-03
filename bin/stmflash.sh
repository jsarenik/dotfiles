#!/bin/sh

test -n "$1" || exit 1
FILE=$1
#LOG=$HOME/st-util.log

#st-flash write ${FILE}bin 0x020000000
#myst

xterm -e "/bin/sh -c \"st-util -1\"" &
xterm -e "arm-none-eabi-gdb ${FILE}elf"

#less $LOG
