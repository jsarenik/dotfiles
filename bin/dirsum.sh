#!/bin/sh

DIR=${1:-'.'}

export LC_ALL=C
export LANG=C

{
cd $DIR
find . -type f | sort | while read f; do md5sum "$f"; done
find . -type d | sort | md5sum
} | sha256sum | cut -b-64
