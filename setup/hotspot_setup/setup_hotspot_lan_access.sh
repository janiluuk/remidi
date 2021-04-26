#!/bin/bash

INIT_FILE=/home/pi/remidi/startup/hotspot.sh
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sudo echo "iptables-restore < /etc/iptables.ipv4.nat" > $INIT_FILE
chmod 755 $INIT_FILE
