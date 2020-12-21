import spidev as SPI
import ST7789
import time

from PIL import Image,ImageDraw,ImageFont

# Raspberry Pi pin configuration:
RST = 27
DC = 25
BL = 24
bus = 0
device = 0

# 240x240 display with hardware SPI:
disp = ST7789.ST7789(SPI.SpiDev(bus, device),RST, DC, BL)

# Initialize library.
disp.Init()

# Clear display.
disp.clear()

# Create blank image for drawing.
image1 = Image.new("RGB", (disp.width, disp.height), "DARKBLUE")
draw = ImageDraw.Draw(image1)
font = ImageFont.truetype('/home/pi/remidi/ui/font.ttf', 24)
print("***draw line")
draw.line([(10,10),(230,10)], fill = "BLUE",width = 5)
draw.line([(230,10),(230,230)], fill = "BLUE",width = 5)
draw.line([(230,230),(10,230)], fill = "BLUE",width = 5)
draw.line([(10,230),(10,10)], fill = "BLUE",width = 5)
print("***draw rectangle")
draw.rectangle([(70,70),(170, 110)],fill = "RED")

print("***draw text")

draw.text((80, 80), 'REMidi', fill = "BLUE", font=font)
draw.text((30, 180), 'December release', fill = "BLUE", font=font)
draw.text((30, 200), '2020 ', fill = "BLUE", font=font)
disp.ShowImage(image1,0,0)
time.sleep(3)

image = Image.open('/home/pi/remidi/ui/pic.jpg')
disp.ShowImage(image,0,0)
