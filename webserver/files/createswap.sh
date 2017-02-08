#!/bin/bash
swapon -s | grep "/swp/.swapfile" > /dev/null 2>&1
val=$?
if [ $val -gt 0 ];
then
    mkdir /swp
    fallocate -l 512M /swp/.swapfile
    chmod 600 /swp/.swapfile
    mkswap /swp/.swapfile
    swapon /swp/.swapfile
    echo "/swp/.swapfile none swap defaults 0 0" >> /etc/fstab
else
  :
fi
