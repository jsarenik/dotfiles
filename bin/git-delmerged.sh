#!/bin/sh

git branch --merged HEAD | grep -v "^\*\|master" | xargs -rn 1 git branch -d
