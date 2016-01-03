#!/bin/sh

DEV=`ip -4 route show default | cut -d" " -f5`
FQDN=`hostname -f`

ip -4 address show dev $DEV | grep inet | tr \  / | cut -d/ -f6 | \
  while read line
  do
    echo -e "$line\t$FQDN\t${FQDN%%.*}"
  done
