#!/bin/sh

while 
  PERC=$(acpi | grep -Eo '[0-9]+%')
do
  xsetroot -name "$PERC"
done
