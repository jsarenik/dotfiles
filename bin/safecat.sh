#!/bin/sh

tmp=$(mktemp)
cat > $tmp
chmod a+r $tmp
test -s $tmp && mv -f $tmp $1
