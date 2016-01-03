#!/bin/sh

MANF=$1
test -s $MANF
groff -T ascii -mandoc $MANF | less
