#!/bin/sh
OPTIONS="--interface spi --display sh1106"
DEMO=$1
killall -9 python3

python3 /home/pi/remidi/ui/luma.examples/examples/$DEMO.py $OPTIONS &

