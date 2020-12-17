#!/bin/bash

cd
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz
tar zxvf bcm2835-1.60.tar.gz 
cd bcm2835-1.60/
sudo ./configure
sudo make && sudo make check && sudo make install

sudo pip3 install pillow
sudo pip3 install numpy
sudo apt-get install libopenjp2-7
sudo apt install libtiff
sudo apt install libtiff5
sudo apt-get install libatlas-base-dev
cd
sudo apt-get update
sudo apt-get install python-pip
sudo pip install RPi.GPIO

