sudo cp -R ./system/* /

sudo udevadm control --reload
sudo service udev restart
sudo systemctl daemon-reload
sudo systemctl enable midi.service
sudo systemctl start midi.service

sudo systemctl enable btmidi.service
sudo systemctl start btmidi.service    
