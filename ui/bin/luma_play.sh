#!/bin/sh
#LCD="sh1106"
LCD="st7789"
OPTIONS="--interface spi --display $LCD"
DEMO=$1
killall -9 python3 >/dev/null


python3 /home/pi/remidi/ui/luma.examples/examples/$DEMO.py $OPTIONS &

