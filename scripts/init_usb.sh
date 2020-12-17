#!/bin/bash

##########################################
# INIT LIBCOMPOSITE
echo "creating composite ethernet & midi OTG Gadget..."
modprobe dwc2
modprobe libcomposite

##########################################
# INIT USB GADGET
echo "INIT USB GADGET"
cd /sys/kernel/config/usb_gadget/
rm -rf midi_over_usb # clear out old if there...
mkdir -p midi_over_usb
cd midi_over_usb

echo 0x1235 > idVendor # Linux Foundation
echo 0x0101 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2

mkdir -p strings/0x409
echo "asdfghlMIDIController34579381" > strings/0x409/serialnumber
echo "manufacturer" > strings/0x409/manufacturer
echo "MIDI Controller" > strings/0x409/product

N="usb0"
C=1

##########################################
# SETUP DEVICES
echo "SETUP DEVICES"

# ETHERNET USB
echo " - ETHERNET USB"
mkdir -p functions/ecm.$N
# first byte of address must be even
HOST="48:6f:73:74:50:43" # "HostPC"
SELF="42:61:64:55:53:42" # "BadUSB"
echo $HOST > functions/ecm.$N/host_addr
echo $SELF > functions/ecm.$N/dev_addr
mkdir -p configs/c.$C
ln -s functions/ecm.$N configs/c.$C/

# MIDI DEVICE USB 
# See new device:  amidi -l
# Get device port: aplaymidi --list
# Sample File:     curl https://www.midiworld.com/download/3861 > techno.midi
# Play MIDI Out:   aplaymidi --port 20:0 techno.midi
echo " - MIDI DEVICE USB"
mkdir -p functions/midi.$N
# id     - ID string for the USB MIDI adapter
echo "pi-zero-midi" > functions/midi.$N/id
mkdir -p configs/c.$C
ln -s functions/midi.$N configs/c.$C/

#########################################


