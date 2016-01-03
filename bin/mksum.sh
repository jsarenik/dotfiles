#!/bin/sh
find . -type f | sort | sed 's/.*/"&"/' | xargs sha256sum > sha256sum
