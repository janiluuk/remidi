## Remidi

Purpose for Remidi device is to enable battery powered wireless midi, audio playback/recording capabilities and multi-user functionality with no-brainer setup and usage tailored for performance use in mind. 
If you can power your controller(s) only via USB, chances are that it works for you.

This repository is a support package that is pre-configured already on ready devices.

## Features

- Multiple user support (max 16, amount of max midi channels), preferably in the same network.
- Works through internal network (LAN / WLAN) and Bluetooth LE connections. (Bluetooth not recommended unless you don't have 2,4ghz wifi / LAN network available.
- Attaches as normal USB device on host machine. (OS X / Windows / Linux / RPI), so no extra hacks needed.
- Supports playing back the audio from remote host. (Headphones, external speaker, bluetooth, chromecast, or borderline stable airplay). 
- Record / manage / play back your performances. Fetch your recordings easily through organized network drive, drop them straight to your DAW.
- Overdubbing previous performance with rollback possibility.
- Includes 1 USB port license for free, for 2 or more simultaneous controllers per Remidi-device, third party license is needed. (Or until have moved completely to some of the open-source solutions)

	
Ready disk-images for Raspberry Pi Zero W & Pi 3 Model A devices.
Can be easily ported to other environments as well.

Feel free to use on your own device, or you can purchase ready built and configured device.

Requirements for using on your own device;
- Raspberry Pi 3 Model A / B or Zero W (WiFi / Bluetooth needed!)
- Battery HAT + battery
- FAST SD card, preferably 170Mb/sec. Has been tested on Sandisk cards which seem to work well.
- Case that is light weight and attachable on the controller. (Unless you prefer wireless solution with wires)
- LCD display for the case with 4 buttons (5-way navi button, 3 buttons) 
- Raspbian (Autumn 2020+) 
- USB cable capable of powering your midi device. If current one works, use that. 10-20cm cable to connect the device to the controller should be enough.

## Installation

- If you wish to have bluetooth support (works up to 10-15m), run btmidisetup.sh *first*. Otherwise ignore.
- Run setup.sh, which will install needed services and tools
- If you wish to enable the device to be ready by default (recommended), run "service virtualusb enable".

For more info on devices, See https://www.remidi.net

