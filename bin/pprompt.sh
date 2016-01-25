#!/bin/sh

pass=$(dialog --stdout --passwordbox "Enter password" 8 8)
echo
echo "I will not tell anyone that you entered $pass" > /dev/tty
