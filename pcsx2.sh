#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

USER=pcsx

CHROOT_DIRECTORY=./chroot
shopt -s nullglob dotglob; 
files=($CHROOT_DIRECTORY/proc/*)

#if (((! ${#files[@]}))); then
#    echo ""
#else
#    echo "Already mounted. Starting..."
#fi

xhost +
chroot --userspec=$USER:$USER $CHROOT_DIRECTORY /bin/bash "/home/$USER/pcsx2/bin/PCSX2-linux.sh" DISPLAY=$DISPLAY
