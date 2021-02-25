#!/bin/bash

sudo apt-get install cmake python3-pip 
cd

pip3 install ST7789
git clone https://github.com/juj/fbcp-ili9341.git
mv fbcp-ili9341 ST7735
cd ST7735
mkdir build
cd build
cmake -DWAVESHARE_ST7789VW_HAT=ON  -DSPI_BUS_CLOCK_DIVISOR=6 -DDISPLAY_ROTATE_180_DEGREES=1  -DBACKLIGHT_CONTROL_FROM_KEYBOARD=ON ..
# -DBACKLIGHT_CONTROL=1
make -j
rm -f /usr/local/bin/fbcp
sudo ln -s /home/pi/ST7735/build/fbcp-ili9341 /usr/local/bin/fbcp 



