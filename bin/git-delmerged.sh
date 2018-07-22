#!/bin/sh

WHAT=${1:-"master"}
git branch --merged $WHAT | grep -v "^\*\|master" | xargs -rn 1 git branch -d
