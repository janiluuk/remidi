from PIL import ImageFont
from luma.core.render import canvas
import helperFunctions
from globalParameters import globalParameters, mediaVariables

page = 0

#Radio station list (screenid: 2)
def draw(device):
    global page
    counter = globalParameters.counter
    menu = mediaVariables.radiomenu

    if counter != globalParameters.oldcounter and counter <= len(menu) and counter >= 0:
        globalParameters.oldcounter = counter
        with canvas(device) as draw:
            loadmenu = []
            for i in range(page, page + 5):
                if len(menu) >= i + 1:
                    loadmenu.append(menu[i])
            helperFunctions.drawMenu(draw, loadmenu)
    #Next page (scrolling)
    if page + counter > page + 3 and len(menu) > 5:
        page += 1
        globalParameters.counter -= 1
    if page + counter > len(menu):
        globalParameters.counter = 0
        page = 0
    if counter < 0: globalParameters.counter = 0

def trigger():
    global page
    counter = globalParameters.counter
    if counter == 0: globalParameters.setScreen(1)
    elif counter != 0: 
        if mediaVariables.loadedPlaylist != "[Radio Streams]":
            helperFunctions.loadRadioStations()
        helperFunctions.playRadioStation(page+counter-1)
    page = 0