#!/bin/sh

FILE=${1:-''}

red=`echo -e '\033[31m'`
green=`echo -e '\033[32m'`
cyan=`echo -e '\033[36m'`
change=`echo -e '\033[1;35;40m'`
yellow=`echo -e '\033[0;33;40m'`
bold=`echo -e '\033[1;37m'`
redred='[31;41m'
NORM=`echo -e '\033[0;m'`

#  -e "s/\s\+/$redred&$NORM/" \
echo -n $NORM
sed -r \
  -e "/^Change [0-9]+.*$/s/^.*$/$change&$NORM$yellow/gi" \
  -e "s/^diff.*$/$bold&$NORM/gi" \
  -e "s/^\+\+\+.*$/$bold&$NORM/gi" \
  -e "s/^---.*$/$bold&$NORM/gi" \
  -e "s/^===.*$/$bold&$NORM/gi" \
  -e "s/^@@.*$/$cyan&$NORM/gi" \
  -e "s/^-.*$/$red&$NORM/gi" \
  -e "s/^\+.*$/$green&$NORM/gi" \
  $FILE | less -ciRQ
