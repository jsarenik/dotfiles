#!/bin/sh

quotes.sh $1 | less -ciRQ

#cat $1 |
#  fmt -w 81 -p '> ' -s |
#/bin/less $1
