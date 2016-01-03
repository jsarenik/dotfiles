#!/bin/sh

WORD=${1-"word"}
wn $WORD -over | sed 's/\(^[0-9].*\)$/\1\n/' | fmt
