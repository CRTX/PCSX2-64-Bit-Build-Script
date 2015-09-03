#!/bin/bash

INSTALL=$(pwd)/chroot #Do not use relative paths /use/full/path/name
SCHROOT=/etc/schroot/schroot.conf
SCHROOTCONF=./schroot.conf
MIRROR=http://archive.ubuntu.com/ubuntu/
HASPCSX2CONFIG=$(schroot -l | grep -cs PCSX2)
PCSXUSER=pcsx
VIDEO_DRIVER=NVIDIA

chrootRun () {
    chroot --userspec=$1:$1 $INSTALL /bin/bash -c "$2 $3"
}

installVideoDriver () {
    if [ $1 = NVIDIA ]; then
        chrootRun root "apt-fast install -y nvidia-346"
    fi
}

if [ ! -d $INSTALL ]; then
    mkdir $INSTALL
fi

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

if [ $HASPCSX2CONFIG -eq 1 ]; then
    debootstrap --variant=minbase --arch=i386 vivid $INSTALL $MIRROR
    ./automount.sh $INSTALL
    cp ./sources.list $INSTALL/etc/apt/sources.list
    cp ./postinstall.sh $INSTALL/root/
    chrootRun root /root/postinstall.sh $PCSXUSER
    installVideoDriver $VIDEO_DRIVER
    cp ./buildpcsx.sh $INSTALL/home/$PCSXUSER/buildpcsx.sh
    chrootRun $PCSXUSER /home/$PCSXUSER/buildpcsx.sh $PCSXUSER
else
    cat "$SCHROOTCONF" >> "$SCHROOT"
    ./$0
fi
