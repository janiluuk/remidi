#!/bin/bash

sudo apt-get update ; sudo apt-get -y install git python-dev python-pip python-numpy cython python-smbus portaudio19-dev libportaudio2 libffi-dev
sudo pip install rtmidi-python pyaudio cffi sounddevice
sudo python setup.py build_ext --inplace

