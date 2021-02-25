#!/bin/bash
sudo raspi-config nonint do_i2c 0
sudo pip3 install luma luma.oled
git clone https://github.com/pimoroni/sh1106-python
cd sh1106-python
sudo ./install.sh
sudo apt-get install python3-pip
sudo pip3 install pillow
sudo pip3 install numpy
sudo apt-get install libopenjp2-7
sudo apt install libtiff
sudo apt install libtiff5
sudo apt install python3-pip
sudo apt-get install libatlas-base-dev
sudo apt-get update
sudo apt-get install python-pip
sudo pip install RPi.GPIO



