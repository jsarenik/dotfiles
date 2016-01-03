#!/bin/sh

let try=0
while true
test -n "$CLEAR_ENV" || {
  echo "Running the tests in clear environment"
  exec env -i \
    PATH=$PATH HOME=$HOME TERM=$TERM CLEAR_ENV=1 COLORTERM=$COLORTERM \
    NODE_PATH=$NODE_PATH NVM_DIR=$NVM_DIR \
    $0
}

do
  let try++
  DISPS=`cd /tmp/.X11-unix && for x in X*; do echo "${x#X}"; done`
  test -n "$try" || exit 1
  echo $DISPS | grep -wq $try && continue
  NUM=$try
  break
done

export DISPLAY=:$NUM

Xvfb $DISPLAY &
trap "kill $!" EXIT

LOG_LEVEL=silly \
  grunt test:all
