#!/bin/sh
# sedgrep

basename=${0##*/}
#[ -r "$1" ] || { echo "usage: $basename [file]"; exit 1; }
unset basename

FILE=${1:-''}

#HEADERS="[A-Z][a-zA-Z\-]+: "
HEADERS="(Date|From|Return-Path|Subject|To): "
C_PATT=`echo -e '\033[1;33m'`
G_PATT=`echo -e '\033[1;30m'`
H_PATT=`echo -e '\033[0;32m'`
N_PATT=`echo -e '\033[1;32m'`
B_PATT=`echo -e '\033[0;36m'`
P_PATT=`echo -e '\033[1;35;40m'`
PACK_PATT=`echo -e '\033[1;36;40m'`
BOLD=`echo -e '\033[1;37m'`
REDBOLD=`echo -e '\033[1;37;41m'`
NORM=`echo -e '\033[0;m'`

QUOTES="[>%:]"
NQUOTES="[^>%:]"

sed -r \
  -e "s/^\[\-\- [a-zA-Z].*/$B_PATT&$NORM/gi" \
  -e "/^-- $/,/^$/s/^.*$/$G_PATT&$NORM/gi" \
  -e "/^Package: /,/^Changelog:$/s/^.*$/$PACK_PATT&$NORM/gi" \
  -e "/^Author: /,/^$/s/^.*$/$P_PATT&$NORM/gi" \
  -e "/^$HEADERS/,/^$/s/^.*$/$C_PATT&$NORM/gi" \
  -e "s/^($QUOTES *$QUOTES *)+($NQUOTES.*|)$/$N_PATT&$NORM/gi" \
  -e "s/^$QUOTES( *$QUOTES *$QUOTES *|)*($NQUOTES.*|)$/$H_PATT&$NORM/gi" \
  -e "/^>>>$/,/^<<<$/s/^.*$/$H_PATT&$NORM/gi" \
  -e "s/^-...- [0-9].*$/$REDBOLD&$NORM/gi" \
  -e "s|([0-9]+/[0-9]+/[0-9]+ [0-9]+:[0-9]+ [ap]m)|$REDBOLD&$NORM|gi" \
  -e "1 s/^-...- [0-9].*$/$REDBOLD&$NORM/gi" \
  $FILE
