#!/bin/bash
# Visit http://www.timeapi.org to find the correct url for your timezone. Then replace the url in the first line
sudo service ntp stop
sudo ntpd -gq
sudo service ntp start
