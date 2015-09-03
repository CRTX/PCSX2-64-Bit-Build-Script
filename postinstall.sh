#!/bin/bash
USER=$1
addgroup $USER
useradd $USER -s /bin/bash -m -g $USER -G sudo
echo '$USER:$USER' | chpasswd

apt-get update
apt-get -y install software-properties-common
add-apt-repository -y ppa:saiarcot895/myppa
apt-get update
apt-get -qq install apt-fast
apt-fast install -y git
apt-fast install -y cmake
apt-fast install -y g++
apt-fast install -y libsdl1.2-dev
apt-fast install -y libaio-dev
apt-fast install -y libsoundtouch-dev
apt-fast install -y portaudio19-dev
apt-fast install -y libpng++-dev
apt-fast install -y gettext
apt-fast install -y libwxgtk3.0-dev
apt-fast install -y libgtk2.0-dev
apt-fast install -y libcanberra-gtk-module
apt-fast install -y liblzma-dev
apt-fast install -y sudo
