#!/bin/sh -e

PATH=/sbin:/usr/sbin:/bin:/usr/bin

ARCH=$(uname -m)
URL=https://www.archlinux.org/packages/extra/$ARCH/linux-zen
V=$(wget -qO - -c --content-disposition $URL | grep -m1 version | cut -d\" -f4)
test -n "$V" || { echo Early error; exit 1; }
F=linux-zen-$V-$ARCH.pkg.tar
test -r $F.* && F=$(ls $F.*)
D="$(echo $V | sed 's/\.zen/-zen/')-zen"
M=/lib/modules/$D
test "$1" = "-f" && { rm -rf $M; rm -rf linux-zen; }
test -d $M && { echo "$M already present! Exiting."; exit 0; }

echo Preparing $F...
test -r $F || wget -c --content-disposition $URL/download/
echo $F | grep -q 'tar$' && F=$(ls $F.*)

test -d linux-zen || mkdir linux-zen
cd linux-zen

A=already-extracted-$V
test -r $A || { echo Extracting $F... && tar xf ../$F && touch $A; }

test -d lib/modules || mkdir -p lib/modules
set -x
mv usr/lib/modules/$D /lib/modules/
rm -rf usr
mv /lib/modules/$D/vmlinuz /boot/vmlinuz-zen

# Extract all compressed modules
find $M -type f -name '*.ko.xz' -exec unxz \{\} \;
find $M -type f -name '*.ko.zst' -exec unzstd \{\} \;

# Depmod
depmod -a $D

# Mkinitfs
mkinitfs $D

# Clean up old versions
set +x
cd /lib/modules
ls -d *-zen | grep -v $D \
  | while read v
do
  echo "Removing old modules of $v..."
  rm -rf $v
done

echo All done.
