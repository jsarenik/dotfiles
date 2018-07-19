#!/bin/sh

# requirements
type host >/dev/null 2>&1 || { echo "'host' utility not found."; exit 1; }

RECORD=${1:-"bitcoin.jasan.tk"}
CHAIN=${2:-"btc"}

host -t txt $RECORD | grep $CHAIN \
  | grep -Eo 'recipient_address=[^;]+' | cut -d= -f2
