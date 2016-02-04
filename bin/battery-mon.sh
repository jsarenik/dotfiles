#!/bin/sh

while 
  ACPI=$(acpi)
do
  echo $ACPI | awk '{print "\"" $3 " " $4 "\""}' | tr -d , | \
    xargs xsetroot -name
  sleep 5
done
