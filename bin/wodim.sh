#!/bin/sh

BURN_DIR=${1:-'/tmp/nonenatoheu'}
BURN_DIR=$(cd $BURN_DIR && pwd) || exit 1
echo $BURN_DIR
SPEED=${2:-"2"}

SIZE=$(genisoimage -R -q -print-size "$BURN_DIR") \
  && genisoimage -R "$BURN_DIR" | \
    wodim -v -dao -eject speed=$SPEED dev=/dev/cdrom tsize=${SIZE}s -
