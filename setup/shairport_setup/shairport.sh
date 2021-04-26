#!/bin/sh

sudo git clone https://github.com/abrasive/shairport.git
cd shairport && sudo ./configure
sudo apt-get install libssl-dev libao-dev libpulse-dev pulseaudio-module-zeroconf pulsemixer
sudo make
sudo make install
sudo cp scripts/debian/init.d/shairport /etc/init.d/shairport
cd /etc/init.d
sudo chmod a+x shairport
sudo update-rc.d shairport defaults
sudo useradd -g audio shairport
sudo service shairport start


