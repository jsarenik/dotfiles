#!/bin/sh

RECORD=${1:-"bitcoin.jasan.tk"}
CHAIN=${2:-"btc"}

host -t txt $RECORD | grep $CHAIN \
  | grep -Eo 'recipient_address=[^;]+' | cut -d= -f2
