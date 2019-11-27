#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)

IMAGE=${1}
OUTDIR=$PWD
test -n "$1" && test -r "$1" && shift
test -n "$1" && { echo $1 | grep -qw '[0-9]\+' || { POST=-${1}; shift; }; }
ARGS="$*"

test -r $IMAGE || {
  cat <<-EOF
	Image $IMAGE not found
	Usage: ./mkpartfiles.sh <image> [[POST] num num ...]
	  <image> can be an xz compressed file
	  [POST] can be a non-numerical suffix for extracted partition images
	  [num] can be a number which matches number of partition
	        in the output of 'partx -gb --show - \$IMAGE'

	Examples:

	  Extract all the partitions from test image:
	    ./mkpartfiles.sh ~/Downloads/test.img

	  Extract first and second partition from the test image
	  and write them into files with "-orig" suffix.
	  Used in ./genupgrade.sh:
	    ./mkpartfiles.sh ~/Downloads/test.img orig 1 2

	  Extract first and second partition from the test image.
	  Used in ./genupgrade.sh
	    ./mkpartfiles.sh test.img 1 2
	EOF
  exit 1
} 1>&2

if
  file $IMAGE | grep -q "XZ compressed"
then
  echo "Extracting the image..."
  unxz $IMAGE
  IMAGE=${IMAGE%.xz}
fi

echo Separating partitions into files
partx -gb --show - $IMAGE \
  | while read id start end size rest
do
  test -n "$ARGS" && {
    unset C
    for i in $ARGS; do test $id -eq $i && C=1; done
    test -n "$C" || continue
  }
  test $id -eq 1 -a -z "$ARGS" && {
    echo "...p0.img${POST} (boot)"
    dd if=$IMAGE of=$OUTDIR/p0.img${POST} count=$((start)) >/dev/null 2>&1
  }
  echo ...p${id}.img${POST}
  dd if=$IMAGE of=$OUTDIR/p${id}.img${POST} \
    skip=$((start)) count=$((size)) >/dev/null 2>&1
done
echo done
