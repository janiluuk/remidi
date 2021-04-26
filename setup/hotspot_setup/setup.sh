#!/bin/sh

sudo apt-get install hostapd dnsmasq
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

cp -f system/etc/dhcpcd.conf.hotspot /etc/dhcpcd.conf


sudo echo "DAEMON_CONF=\"/etc/hostapd/hostapd.conf\"" >> /etc/default/hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd
sudo service dnsmasq start


