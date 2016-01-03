#!/bin/sh
# This is my-code.sh script used for house-keeping the source
# Updated on Sun Jan 3 13:33:14 CET 2016
# To see it in action, run 'my-code.sh my-code.sh'

################
### SETTINGS ###

# Input indent, used for unexpand(1), defaults to two spaces.
indent=4

# Output indent, used for expand(1), defaults to $indent.
# Even if it is the same as $indent, it converts TABs...
oindent=$indent

# END SETTINGS #
################

####################
# MORE EXAMPLES
####################
#  Tree example:
# -----------------
#find . -type f -name "*.sh" | while read file
#  do my-code.sh $file | patch -Np1
#done
#
#  Example with detection of file-type:
# --------------------------------------
#find . -type f -name "*.sh" | while read file
#  do file $file | grep text && my-code.sh $file | patch -Np1
#done
#
#  Example suitable for MRG.git repository
#  (see http://ooo.englab.brq.redhat.com/c/MRG):
# -----------------------------------------------
#find . -path ./.git -prune -o -print -type f | grep -v Makefile | \
#  while read file
#  do file $file | grep text && my-code.sh $file | patch -Np1
#done

# If there is not exactly one argument, exit
test $# -ne 1 && { echo "Usage: ${0##*/} <file>" >&2; exit 1; }

# If the argument is not a readable file, exit
test -r $1 || exit 1

# Temporary file with modifications
tmp=`mktemp /tmp/${0##*/}.XXXXXXX`
# Remove the temp-file on exit
trap "rm -rf $tmp" 0 3

# This block groups the pipes used for processing the file.
# You can optionally comment the lines or add more.
{
  unexpand -t$indent --first-only |
  expand -i -t$oindent |
  sed 's/\s\+$//'
} < "$1" > $tmp

diff -u "$1" $tmp
exit $?
# Following is an example text.
Some text. 
The previous line contains space at the end of line.
	- This line contains deliberate TAB at the beginning.
	- Run 'my-code.sh <file> | patch -Np1' to patch file
	  after processing it.
	- Only TABs in the beginning whitespace-part of line are expanded:
		<-- these 2 TABs are expanded, 		<-- these stay as TABs
