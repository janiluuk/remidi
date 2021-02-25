#!/bin/sh

sudo apt-get install python3-dev python3-pip libfreetype6-dev libjpeg-dev build-essential libopenjp2-7 libtiff5 screen
sudo pip3 install -r requirements.txt
sudo cp ui.service /etc/systemd/system/
sudo systemctl daemon-reload 
#sudo systemctl enable oled.service