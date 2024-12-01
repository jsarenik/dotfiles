#!/bin/sh
#
# Witness sign

tmp=$(mktemp /dev/shm/ws-XXXXXX)
trap "rm -rf ${tmp}*" INT QUIT EXIT

test "$1" = "-h" && {
  cat <<-EOF
	Options:
	  -w <URL> - download and check
	  -c <wsk> - verify
	  -x <ext> - set file extension
	  -u       - upload from stdin
	EOF
  exit
}

test "$1" = "-w" && {
  c=${2%.*}
  c=$(echo "${c##*/}" | tr . 0 | tr -d '\./:' | tr - " ")
  wget -qO - "$2" | ws.sh -c $c
  exit
}

if
  test $(echo $1 | wc -c) -eq 65
then
  MH=$1
  shift
else
  cat > $tmp
  MH=$(sha256sum < $tmp | cut -b-64)
fi

# Check
# Ex.:  $ echo MACES | ws.sh -c ws842026 c1be65
#       OK
test "$1" = "-c" && {
  BC=$(echo $2 | cut -d- -f1 | tr . 0 | tr -dc '[0-9]')
  echo $2 | grep -q - \
    && WS=$(echo $2 | cut -d- -f2 | tr 0 . | grep .) \
    || WS=$(echo $3 | tr 0 .)
  BH=$(bitcoin-cli getblockhash $BC)
  sk=$(shortkode.sh $BH | tr . 0 | tr -d " ")
  skm=$(shortkode.sh $MH | tr . 0 | tr -d " ")
  CS=$(printf '%x' "$(( 0x$sk ^ 0x$skm ))" | tr 0 .)
  test "$WS" = "$CS" && { echo OK; exit 0; }
  exit 1
}

BC=$(bitcoin-cli getblockcount)
BH=$(bitcoin-cli getblockhash $BC)
sk=$(shortkode.sh $BH | tr . 0 | tr -d " ")
#echo $BC $sk

skm=$(shortkode.sh $MH | tr . 0 | tr -d " ")
#echo $skm

out=$(printf '%s %x' $BC \
      "$(( 0x$sk ^ 0x$skm ))")

ext=txt
test "$1" = "-x" && {
  ext=$2
  shift 2
}
fn=$(echo $out | tr "0 " ".-")
test "$1" = "-u" && {
  scp $tmp singer:web/ln/ws/${fn}.$ext
  echo https://anyone.eu.org/ws/$fn.$ext
}
echo ws $fn
rm -f ${tmp}*
