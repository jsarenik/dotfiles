#!/bin/sh

V=$(curl -s "https://github.com/go-gitea/gitea/releases" \
  | grep -m1 -o "/go-gitea/gitea/tree/v[\.0-9]\+" 2>/dev/null)
LV=$(/usr/local/bin/gitea --version | awk '{print $3}')
V=${V##*/}
V=${V#v}
test "$V" = "$LV" && { echo "No new version found. Exiting."; exit 1; }
KEY=7C9E68152594688862D62AF62D9AE806EC1592E2
gpg --list-keys $KEY \
  || gpg --keyserver pgp.mit.edu --recv $KEY
F=gitea-${V}-linux-amd64
URL=${1:-"https://github.com/go-gitea/gitea/releases/download/v$V/$F"}
echo $V; echo $F; echo $URL
wget -qc $URL $URL.sha256 $URL.asc
 
gpg --verify $F.asc $F || exit 1
sha256sum -c $F.sha256 || exit 1

cmp $F /usr/local/bin/gitea || {
  echo Upgrading to $V
  systemctl stop gitea
  cat $F > /usr/local/bin/gitea
  systemctl start gitea
}
