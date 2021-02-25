from luma.core.interface.serial import i2c, spi
from luma.core.render import canvas
from luma.core import lib

from luma.oled.device import sh1106
import RPi.GPIO as GPIO

import sys
import time
import subprocess
import os
import string

from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont

from PIL import Image,ImageDraw,ImageFont

# General

uipath = "/home/pi/remidi/ui"
version = "Feb 2021"


#GPIO define
RST_PIN  = 25 #Reset
CS_PIN   = 8
DC_PIN   = 24
JS_U_PIN = 6  #Joystick Up
JS_D_PIN = 19 #Joystick Down
JS_L_PIN = 5  #Joystick Left
JS_R_PIN = 26 #Joystick Right
JS_P_PIN = 13 #Joystick Pressed
BTN1_PIN = 21
BTN2_PIN = 20
BTN3_PIN = 16

# Some constants
SCREEN_LINES = 4
SCREEN_SAVER = 20.0
CHAR_WIDTH = 19
font = ImageFont.load_default()
width = 128
height = 64

# Raspberry Pi pin configuration:
RST = 27
DC = 25
BL = 24
bus = 0
device = 0

state = 0 #System state: 0 - scrren is off; equal to channel number (e.g. BTN2_PIN, JS_P_PIN) otherwise
horz = 1 #Selection choice: 0 - Right; 1 - Left
vert = 3 #Selection choice: 1 - Top; 2 - Middle; 3 - Bottom
stamp = time.time() #Current timestamp
start = time.time() #Start screen saver count down


# 240x240 display with hardware SPI:
#disp = SH1106.SH1106()

# Initialize the display...
serial = spi(device=0, port=0, bus_speed_hz = 8000000, transfer_size = 4096, gpio_DC = DC_PIN, gpio_RST = RST_PIN)
device = sh1106(serial, rotate=2) #sh1106


# Create blank image for drawing.
image1 = Image.new("RGB", (disp.width, disp.height), "DARKBLUE")
draw = ImageDraw.Draw(image1)
font = ImageFont.truetype(uipath+'/res/fonts/introfont.ttf', 32)
fontbig = ImageFont.truetype(uipath+'/res/fonts/fontbig.ttf', 48)

print("***draw line")
draw.line([(10,10),(230,10)], fill = "BLUE",width = 5)
draw.line([(230,10),(230,230)], fill = "PURPLE",width = 5)
draw.line([(230,230),(10,230)], fill = "PURPLE",width = 5)
draw.line([(10,230),(10,10)], fill = "BLUE",width = 5)
print("***draw rectangle")
draw.rectangle([(30,30),(210, 140)],fill = "RED")

print("***draw text")

draw.text((40, 40), 'ReMidi', fill = "YELLOW", font=fontbig)
draw.text((30, 180), 'Version', fill = "BLUE", font=font)
draw.text((30, 200), version, fill = "BLUE", font=font)
disp.ShowImage(image1,0,0)
time.sleep(3)
disp.clear()

image1 = Image.new("RGB", (disp.width, disp.height), "BLACK")
jpg = Image.open(uipath+'/res/images/remidi_128.jpg')
disp.ShowImage(jpg,0,0)
time.sleep(30)

