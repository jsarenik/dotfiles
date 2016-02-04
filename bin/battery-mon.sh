#!/bin/sh

while 
  PERC=$(acpi | grep -Eo '[0-9]+%')
do
  xargs xsetroot -name "$PERC"
done
