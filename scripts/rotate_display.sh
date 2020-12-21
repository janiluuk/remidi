#!/bin/bash
# script to rotate display
# 2017-02-18

# copy sed script to a temporary file
cat << EOF > /tmp/sedscr
/^.?display_rotate/{
    s/=0/=3/
    s/^(.)/#\1/
    s/^##//
}
EOF

# locate any display_rotate command and toggle its effect
sed -r -f /tmp/sedscr /boot/config.txt >/tmp/config.txt
# copy temporary file to /boot directory and reboot
sudo cp /tmp/config.txt /boot/config.txt
sudo reboot

