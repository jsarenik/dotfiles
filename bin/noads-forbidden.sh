#!/bin/sh
getem() {
  wget -4 -t 0 -O - "$1"
}

{
  getem "http://www.mvps.org/winhelp2002/hosts.txt"
  getem "http://sysctl.org/cameleon/hosts"
  getem "http://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
  getem "http://someonewhocares.org/hosts/hosts"
} | {
  dos2unix \
    | sed \
      -e '/localhost/d' \
      -e '/^#/d' \
      -e '/^$/d'
  } | sort -u
# | awk '{print $2}' | sort -u
