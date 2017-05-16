#!/bin/sh -e

NOTES=$HOME/notes
LOCK=/tmp/notelock.$USER

mkdir $LOCK || exit 1

chmod u+w $NOTES
{ echo; date; echo $*; cat; date; } >> $NOTES
chmod u-w $NOTES

rmdir $LOCK
