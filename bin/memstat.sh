#!/bin/sh

#Source : http://www.linoxide.com/linux-shell-script/linux-memory-usage-program/
#Parent : http://www.linoxide.com/guide/scripts-pdf.html
tabw=8
mark=40

test $(id -u) -eq 0 || {
  echo "This script must be run as root" 1>&2
  exit 1
}

get_process_mem ()
{
  PID=$1

  test -f /proc/$PID/status -a -f /proc/$PID/smaps || return 1

  # count memory usage, Pss, Private and Shared = Pss-Private
  both=$(busybox awk '/^Pss:/{pss+=$2} /^Private/{priv+=$2} \
         END {print pss*1024 ":" priv*1024}' /proc/$PID/smaps \
  )
  test "$both" = "0:0" && return 0
  Pss=${both%:*}
  Private=${both#*:}

  # count Pss and Private memory, to avoid errors
  if test x"$Rss" != "x" -o x"$Private" != "x"
  then

    Shared=$((${Pss}-${Private}))
    Name=$(busybox grep -e "^Name:" /proc/$PID/status | cut -d: -f2)

    # keep all results in bytes
    Sum=$((${Shared}+${Private}))

    printf "$Name $Sum\n"
  fi
}

E1=1024
E2=$(($E1*1024))
E3=$(($E2*1024))

#this function make conversion from bytes to Kb or Mb or Gb
convert()
{
  value=$1
  power=1

  # convert while value is bigger than 1024
  test $value -ge $E3 && { power=3; E=$E3; } || {
  test $value -ge $E2 && { power=2; E=$E2; } || {
  test $value -ge $E1 && { power=1; E=$E1; }; }; }
  test -n "$E" \
    && value=$(echo $value | busybox awk "{printf \"%.2f\", \$1/$E}")

  # this part get b,kb,mb or gb according to number of divisions
  case $power in
    0) unit=B;;
    1) unit=KiB;;
    2) unit=MiB;;
    3) unit=GiB;;
  esac

  printf "${value} ${unit}"
}

TMPRES=$(busybox mktemp)
touch $TMPRES-1
touch $TMPRES-2
touch $TMPRES-3
trap "rm -rf ${TMPRES}*" INT QUIT EXIT

test $# -eq 0 && pids=$(cd /proc; busybox ls -1 | busybox grep "^[0-9]\+") || {
  npids=""
  pids=$*
  for pid in $pids
  do
    if
      test $pid -gt 0 2>/dev/null
    then
      npids="$pid $npids"
    else
      npids="$(pgrep $pid) $npids"
    fi
  done
  pids="$npids"
}

# sort result by memory usage
for i in $pids
do
  get_process_mem $i
done | sort -gr -k 2 > ${TMPRES}-2

total=0
for Name in $(busybox cat ${TMPRES}-2 | awk '{print $1}' | sort -u)
do count=$(busybox grep -c "$Name" ${TMPRES}-2)
  test $count -eq 1 && count="" || count="($count)"
  Sum=$(busybox awk -v src=$Name '{if ($1==src) {sum+=$2}} END {print sum}' \
          ${TMPRES}-2)
  total=$(($total+$Sum))
  printf "${Name}${count} ${Sum}\n" >>${TMPRES}-3
done

cat ${TMPRES}-3 | sort -gr -k 2 | uniq > ${TMPRES}-1

#printf "Private \t + \t Shared \t = \t RAM used \t Program\n"
while read a b
do
  charz=$(echo $a | busybox wc -c)
  tabz=$((($mark-$charz)/$tabw))
  printf "$a"
  for i in $(busybox seq $tabz); do printf "\t"; done
  echo $(convert $b)
done < ${TMPRES}-1

echo --------------------------------------------------------
echo total: $(convert $total)
echo ========================================================
