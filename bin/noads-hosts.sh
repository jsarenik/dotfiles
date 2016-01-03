#!/bin/sh
#[ -z $DISPLAY ] && DIALOG=dialog || DIALOG=Xdialog
DIALOG=dialog
[ ! -f /etc/hosts.usr ] && touch /etc/hosts && cp -f /etc/hosts /etc/hosts.usr
for x in `$DIALOG --stdout --checklist "Choose your ad blocking service(s)" 0 0 5 1 "mvps.org" ON 2 "systcl.org" ON 3 "technobeta.com" off 4 "yoyo.org" ON 5 "someonewhocares" off 6 "turn off adblocking" off |tr "/" " " |tr '\"' ' '`; do
   case $x in
   1)wget -c -4 -t 0 -O /tmp/adlist1 'http://www.mvps.org/winhelp2002/hosts.txt';;
   2)wget -c -4 -t 0 -O /tmp/adlist2 'http://sysctl.org/cameleon/hosts';;
   3)wget -c -4 -t 0 -O /tmp/adlist3 'http://www.technobeta.com/download/urlfilter.ini';;
   4)wget -c -4 -t 0 -O /tmp/adlist4 'http://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext';;
   5)wget -c -4 -t 0 -O /tmp/adlist5 'http://someonewhocares.org/hosts/hosts';;
   6)ln -sf /etc/hosts.usr /etc/hosts && exit;;
   *)echo $x;;
   esac
done
touch /tmp/adlist{1,2,3,4}
{
cat /etc/hosts.usr
{
cat /etc/hosts.myadd
cat /tmp/adlist* | grep -v localhost | sed -e 's/^[ \t]*//' -e 's/\t/ /g' -e 's/  / /g' -e 's/127\.0\.0\.1/127.0.0.127/' | grep ^[1-9] | dos2unix
} | sort -u
} > /etc/hosts.adblock
ln -sf /etc/hosts.adblock /etc/hosts
