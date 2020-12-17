#!/bin/bash

if ! pidof jackd &> /dev/null
then
  sudo killall ifplugd &> /dev/null
  sudo killall dhclient-bin &> /dev/null
  sudo service ntp stop &> /dev/null
  sudo service triggerhappy stop &> /dev/null
  sudo service ifplugd stop &> /dev/null
  sudo service dbus stop &> /dev/null
  sudo killall console-kit-daemon &> /dev/null
  sudo killall polkitd &> /dev/null
  killall gvfsd &> /dev/null
  killall dbus-daemon &> /dev/null
  killall dbus-launch &> /dev/null
  sudo mount -o remount,size=128M /dev/shm &> /dev/null
  echo -n performance | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &> /dev/null
  if ip addr | grep wlan &> /dev/null
  then
    echo -n "1-1.1:1.0" | sudo tee /sys/bus/usb/drivers/smsc95xx/unbind &> /dev/null
  fi
  jackd -P84 -p128 -t2000 -d alsa -dhw:UA25 -p512 -n2 -r44100 -s -P -Xseq &> /dev/null &
fi

jack_wait -w &> /dev/null

if ! pidof linuxsampler &> /dev/null
then
  linuxsampler --instruments-db-location $HOME/LinuxSampler/instruments.db &> /dev/null &
  sleep 5
  cat $HOME/LinuxSampler/SalamanderGrandPianoV3.lscp | netcat -q 3 localhost 8888 &> /dev/null &
fi

while [ "$STATUS" != "100" ]
do
  STATUS=$(echo "GET CHANNEL INFO 0" | netcat -q 3 localhost 8888 | grep INSTRUMENT_STATUS | cut -d " " -f 2 | tr -d '\r\n')
done

jack_connect LinuxSampler:0 system:playback_1 &> /dev/null
jack_connect LinuxSampler:1 system:playback_2 &> /dev/null
#jack_connect alsa_pcm:MPK-mini/midi_capture_1 LinuxSampler:midi_in_0 &> /dev/null
jack_connect alsa_pcm:USB-Keystation-61es/midi_capture_1 LinuxSampler:midi_in_0 &> /dev/null

jack_midiseq Sequencer 176400 0 69 20000 22050 57 20000 44100 64 20000 66150 67 20000 &
sleep 4
jack_connect Sequencer:out LinuxSampler:midi_in_0
sleep 3.5
jack_disconnect Sequencer:out LinuxSampler:midi_in_0
killall jack_midiseq

exit 0

