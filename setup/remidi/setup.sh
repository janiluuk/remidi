#!/bin/sh
echo "Installing Remidi base system"

sudo cp -R ./system/* /

sudo usermod -a -G spi,gpio pi

echo "Installing RPI-readonly"

cd /tmp
git clone https://gitlab.com/larsfp/rpi-readonly
cd rpi-readonly
sudo ./setup.sh

