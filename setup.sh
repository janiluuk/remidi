#!/bin/bash
apt-get update
apt-get install git
cd /home/pi
git clone https://www.github.com/janiluuk/remidi.git
cd remidi/setup
sudo ./setup.sh

