from os import system
import serial

import sys
import random
from pathlib import Path
from time import sleep
from luma.core.interface.serial import i2c
from luma.core.render import canvas
from luma.oled.device import sh1106
from opts import get_device,get_device_bindings
import opts
from luma.core.render import canvas
from luma.core.sprite_system import framerate_regulator
import time
import config
import traceback

import RPi.GPIO as GPIO

import time
import subprocess

from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont


def make_font(name, size):
    font_path = str(Path(__file__).resolve().parent.joinpath('fonts', name))
    return ImageFont.truetype(font_path, size)


def UpdateDisplay(z1,z2,z3):
    """Pass in the three zones and they will be sent to the screen"""
    get_device_bindings()

    device = get_device()

    # Make a black canvas the size of the entire screen
    whole = Image.new("1", (128,64))

    # Now paste in the 3 zones to form the whole
    whole.paste(z1, (2,2))        # zone1 at top-left
    whole.paste(z2, (66,2))       # zone2 at top-right
    whole.paste(z3, (2,34))       # zone3 across the bottom

    # I save the image here, but you would write it to the screen with "device.display()"
    device.display(whole)
    return

# Make zone1 dark grey and annotate it
z1 = Image.new("1", (60,30))
z1draw = ImageDraw.Draw(z1)
z1draw.text((10,10),"Zone1", fill="white")

# Make zone2 mid-grey and annotate it
z2 = Image.new("1", (60,30))
z2draw = ImageDraw.Draw(z2)
z2draw.text((10,10),"Zone2", fill="white")

# Make zone3 light grey and annotate it
z3 = Image.new("1", (124,28))
z3draw = ImageDraw.Draw(z3)
z3draw.text((10,10),"Zone3", fill="white")

# Blit all zones to display
UpdateDisplay(z1,z2,z3)



def main(num_iterations=sys.maxsize):
    device = get_device()
    regulator = framerate_regulator(fps=4)
    font = make_font("fontawesome-webfont.ttf", device.height - 10)
    i = 0
    menu_length = len(opts.fonts)

    # try:
    while 1:
        with regulator:                       
            num_iterations -= 1
            if num_iterations == 0:
                break
        
            with canvas(device) as draw:
                if GPIO.input(opts.KEY_DOWN_PIN): # button is released
                    i -= 1

                    if i < 0:
                        i = 100
                    draw.polygon([(10, 10), (15, 1), (20, 10)], outline=255, fill=0)  #Up
                else:
                    draw.polygon([(10, 10), (15, 1), (20, 10)], outline=255, fill=1)  #Up

                if GPIO.input(opts.KEY_UP_PIN): # button is released
                    i += 1
                    if i > menu_length:
                        i = 0                
                    draw.polygon([(15, 30), (20, 21), (10, 21)], outline=255, fill=0) #down
                else:
                    draw.polygon([(15, 30), (20, 21), (10, 21)], outline=255, fill=1) #down
                    

                code=opts.fonts[i]
                w, h = draw.textsize(text=code, font=font)
                left = (device.width - w) / 2
                top = (device.height - h) / 2
                z2 = Image.new("1", (60,30))
                draw.text((left, top), text=code, font=font, fill="white")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
