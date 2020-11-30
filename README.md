## Remidi

Remidi is a Raspberry Pi overlay consisting of tools and system configurations to enable battery powered wireless midi, audio playback and recording capabilities on almost any usb powered midi controller.

This is a support package that is pre-configured.

- Multiple user support (max 16, amount of max midi channels), preferably in the same network.
- Works through internal network (LAN / WLAN) and Bluetooth LE connections.
- Attaches as normal USB device on host machine. (OS X / Windows / Linux / RPI), so no extra hacks needed.
- Supports playing back the audio from remote host. (Headphones or speaker) 
- Record / manage your performances. Fetch your recordings easily through shared network drive.
- Includes 1 USB port license for free, for 2 or more simultaneous controllers per Remidi-device, third party license is needed.
	
Ready disk-images for Raspberry Pi Zero W & Pi 3 Model A devices.
Can be easily ported to other environments as well.

Feel free to use on your own device, or you can purchase ready configured one optimized for the purpose.

## Installation

- If you wish to have bluetooth support (works up to 10-15m), run btmidisetup.sh first. Otherwise ignore.
- Run setup.sh, which will install needed services and tools
- If you wish to enable the device to be ready by default (recommended), run "service virtualusb enable".


For more info on devices, See https://www.remidi.net
