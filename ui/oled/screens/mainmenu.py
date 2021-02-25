from PIL import ImageFont
from luma.core.render import canvas
import helperFunctions
from globalParameters import globalParameters

#Main menu (screenid: 1)
def draw(device):
    faicons = ImageFont.truetype(globalParameters.font_icons, size=18)
    counter = globalParameters.counter
    if counter != globalParameters.oldcounter and counter <= 3 and counter >= 0:
        globalParameters.oldcounter = counter
        with canvas(device) as draw:
            #rectangle as selection marker
            if counter < 3: #currently 3 icons in one row
                y = 2
                x = 7 + counter * 35
            else:
                y = 35
                x = 6 + (counter - 3) * 35
            draw.rectangle((x, y, x+25, y+25), outline=255, fill=0)
            
            #icons as menu buttons
            draw.text((10, 5), text="\uf0a8", font=faicons, fill="white") #back
            draw.text((45, 5), text="\uf519", font=faicons, fill="white") #radio (old icon: f145)
            draw.text((82, 5), text="\uf1c7", font=faicons, fill="white") #playlists
            draw.text((10, 40), text="\uf011", font=faicons, fill="white") #shutdown
    
    #Keep the cursor in the screen
    if counter > 3: globalParameters.counter = 0
    if counter < 0: globalParameters.counter = 0

def trigger():
    counter = globalParameters.counter
    if counter == 0: globalParameters.setScreen(0)
    elif counter == 1: 
        globalParameters.setScreen(2)
    elif counter == 2: 
        globalParameters.setScreen(4)
    elif counter == 3: globalParameters.setScreen(3)