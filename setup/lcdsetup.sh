#!/bin/bash

cd
sudo apt-get install wiringpi
wget https://project-downloads.drogon.net/wiringpi-latest.deb
sudo dpkg -i wiringpi-latest.deb
gpio -v

cd
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz
tar zxvf bcm2835-1.60.tar.gz 
cd bcm2835-1.60/
sudo ./configure
sudo make && sudo make check && sudo make install

cd
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz
tar zxvf bcm2835-1.60.tar.gz 
cd bcm2835-1.60/
sudo ./configure
sudo make && sudo make check && sudo make install

cd
sudo apt-get update
sudo apt-get install python-pip
sudo pip install RPi.GPIO

cd
sudo apt-get update
sudo apt-get install python3-pip
sudo pip3 install RPi.GPIO

sudo apt-get install python-dev python-pip libfreetype6-dev libjpeg-dev
sudo -H pip install --upgrade pip
sudo apt-get purge python-pip
sudo -H pip install --upgrade luma.oled

cd
sudo python -m pip install --upgrade pip setuptools wheel
git clone https://github.com/adafruit/Adafruit_Python_SSD1306.git
cd Adafruit_Python_SSD1306
sudo python setup.py install

cd
pip3 install ST7789
