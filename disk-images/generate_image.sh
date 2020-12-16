#!/bin/bash -v
# CREATE AN ISO IMAGE FOR REMIDI
#
# USAGE: chmod 777 generate_image.sh ; nohup sudo ./generate_image.sh &

set -e

sudo apt-get update && sudo apt-get install -y cdebootstrap kpartx parted sshpass zip

image_name=remidi_$(date "+%Y%m%d").img
image_size=1300
hostname=remidi_
root_password=root
http=http://mirrordirector.raspbian.org/raspbian/

dd if=/dev/zero of=$image_name  bs=1M  count=$image_size
fdisk $image_name <<EOF
o
n



+64M
a
t
c
n




w
EOF

kpartx -av $image_name
partprobe /dev/loop0
bootpart=/dev/mapper/loop0p1
rootpart=/dev/mapper/loop0p2

mkdosfs -n BOOT $bootpart
mkfs.ext4 -L ROOT $rootpart
sync

fdisk -l $image_name
mkdir -v sdcard
mount -v -t ext4 -o sync $rootpart sdcard

cdebootstrap --arch=armhf buster sdcard $http --include=locales --allow-unauthenticated

sync

mount -v -t vfat -o sync $bootpart sdcard/boot

echo root:$root_password | chroot sdcard chpasswd

wget -O sdcard/raspberrypi.gpg.key http://archive.raspberrypi.org/debian/raspberrypi.gpg.key
chroot sdcard apt-key add raspberrypi.gpg.key
rm -v sdcard/raspberrypi.gpg.key
wget -O sdcard/raspbian.public.key http://mirrordirector.raspbian.org/raspbian.public.key
chroot sdcard apt-key add raspbian.public.key
rm -v sdcard/raspbian.public.key
chroot sdcard apt-key list

sed -i sdcard/etc/apt/sources.list -e "s/main/main contrib non-free firmware/"
#echo "deb http://archive.raspberrypi.org/debian/ wheezy main" >> sdcard/etc/apt/sources.list
echo "deb http://archive.raspberrypi.org/debian/ buster main" >> sdcard/etc/apt/sources.list

echo Etc/UTC > sdcard/etc/timezone
echo en_GB.UTF-8 UTF-8 > sdcard/etc/locale.gen
cp -v /etc/default/keyboard sdcard/etc/default/keyboard
echo $hostname > sdcard/etc/hostname
echo "127.0.1.1 $hostname" >> sdcard/etc/hosts
chroot sdcard locale-gen LANG="en_GB.UTF-8"
chroot sdcard dpkg-reconfigure -f noninteractive locales

cat <<EOF > sdcard/boot/cmdline.txt
root=/dev/mmcblk0p2 ro rootwait console=tty1 selinux=0 plymouth.enable=0 smsc95xx.turbo_mode=N dwc_otg.lpm_enable=0 elevator=noop
EOF

cat <<EOF > sdcard/boot/config.txt
device_tree_param=i2c_arm=on
enable_uart=1
dtoverlay=pi3-miniuart-bt
#dtoverlay=midi-uart0
gpu_mem=64
boot_delay=0
disable_splash=1
disable_audio_dither=1
dtparam=audio=on
EOF

cat <<EOF > sdcard/etc/fstab
/dev/sda1       /media          auto    nofail            0       0
EOF
#/dev/sdb1       /media          auto    nofail            0       0

# "allow-hotplug" instead of "auto" very important to prevent blocking on boot if no network present
cat <<EOF > sdcard/etc/network/interfaces
auto lo
iface lo inet loopback

allow-hotplug wlan0
iface wlan0 inet dhcp
EOF

#echo "timeout 10;" >> sdcard/etc/dhcp/dhclient.conf
#echo "retry 1;" >> sdcard/etc/dhcp/dhclient.conf

chroot sdcard apt-get update
chroot sdcard apt-get -y upgrade
chroot sdcard apt-get -y dist-upgrade
chroot sdcard apt-get -y install libraspberrypi-bin libraspberrypi-dev libraspberrypi0 raspberrypi-bootloader ssh wireless-tools wpasupplicant usbutils
chroot sdcard apt-get clean
chroot sdcard apt-get -y install build-essential python-dev python-pip cython python-smbus python-numpy python-rpi.gpio python-serial portaudio19-dev alsa-utils git libportaudio2 libffi-dev
chroot sdcard apt-get clean
chroot sdcard apt-get autoremove -y
chroot sdcard pip install rtmidi-python pyaudio cffi sounddevice

# Allowing root to log into $release with password... "
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' sdcard/etc/ssh/sshd_config

# remidi
chroot sdcard sh -c "cd /root ; git clone https://github.com/janiluuk/remidi.git ; cd remidi ; python setup.py build_ext --inplace"

cat <<EOF > sdcard/root/remidi/remidi.sh
#!/bin/sh
python /root/remidi/remidi.py
EOF

chmod 777 sdcard/root/remidi/remidi.sh

cat <<EOF > sdcard/etc/systemd/system/remidi.service
[Unit]
Description=Starts remidi
DefaultDependencies=false

[Service]
Type=simple
ExecStart=/root/remidi/remidi.sh
WorkingDirectory=/root/remidi/

[Install]
WantedBy=local-fs.target
EOF

cat <<EOF > sdcard/etc/motd

Welcome to remidi!
######################
* The filesystem is read-only, see http://www.remidi.org/faq#readonly
  Here is how to remount as read-write:  mount -o remount,rw /
* The remidi program (/root/remidi/remidi.py) should be
  up and running. If not, try:  systemctl status remidi
######################

EOF

sed -i 's/ENV{pvolume}:="-20dB"/ENV{pvolume}:="-10dB"/' sdcard/usr/share/alsa/init/default

chroot sdcard systemctl enable /etc/systemd/system/remidi.service

sed -i 's/USE_SERIALPORT_MIDI = False/USE_SERIALPORT_MIDI = True/' sdcard/root/remidi/remidi.py
sed -i 's/USE_I2C_7SEGMENTDISPLAY = False/USE_I2C_7SEGMENTDISPLAY = True/' sdcard/root/remidi/remidi.py
sed -i 's/USE_BUTTONS = False/USE_BUTTONS = True/' sdcard/root/remidi/remidi.py
sed -i 's,SAMPLES_DIR = ".",SAMPLES_DIR = "/media/",' sdcard/root/remidi/remidi.py

echo 'i2c-dev' >> sdcard/etc/modules
echo 'snd_bcm2835' >> sdcard/etc/modules

# Unmounting mount points
sync

umount -v sdcard/boot
umount -v sdcard

kpartx -dv $image_name

sync

zip $image_name.zip $image_name

exit 0