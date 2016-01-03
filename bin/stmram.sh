#!/bin/sh

test -n "$1" || exit 1
FILE=$1
XTERM=xterm

st-flash write ${FILE}.bin 0x020000000
sleep 1
$XTERM -e "st-util -1 -n" &
$XTERM -e "arm-none-eabi-gdb ${FILE}.elf"
