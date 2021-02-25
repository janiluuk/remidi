#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-pip python3-pip swig
sudo apt-get install portaudio19-dev python-pyaudio python3-pyaudio
sudo pip3 install spidev
git clone https://github.com/respeaker/seeed-voicecard.git
cd seeed-voicecard
sudo ./install.sh
sudo pip install rpi.gpio  swig	
sudo pip install snowboy

