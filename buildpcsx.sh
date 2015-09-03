CORES=$(grep -w -c processor /proc/cpuinfo)

cd /home/$1

git clone https://github.com/PCSX2/pcsx2.git pcsx2
cd pcsx2
mkdir bin/games
mkdir -p /home/$1/.local/share
./build.sh --release
