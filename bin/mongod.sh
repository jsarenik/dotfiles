#!/bin/sh

#export PATH=$HOME/opt/mongodb-linux-x86_64-2.4.7/bin:$PATH

sudo sh -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo sh -c "echo 512 > /proc/sys/net/core/somaxconn"
sudo sysctl -w vm.overcommit_memory=1
mongod --dbpath $HOME/mongodb
