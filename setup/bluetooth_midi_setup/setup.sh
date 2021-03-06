#!/bin/sh

echo "Installing bluetooth midi system"

git clone https://github.com/oxesoft/bluez
sudo apt-get install -y autotools-dev libtool autoconf
sudo apt-get install -y libasound2-dev
sudo apt-get install -y libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev
cd bluez
./bootstrap
./configure --enable-midi --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var
make
sudo make install
cd ..
sudo cp -R ./system/* /
sudo udevadm control --reload
sudo service udev restart
sudo systemctl daemon-reload
sudo systemctl enable midi.service
sudo systemctl start midi.service

sudo systemctl enable btmidi.service
sudo systemctl start btmidi.service    

