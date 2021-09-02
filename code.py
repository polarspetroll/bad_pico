from adafruit_hid.keyboard_layout_us import KeyboardLayoutUS
from adafruit_hid.keyboard import Keyboard
from adafruit_hid.keycode import Keycode
import digitalio as dgio
from time import sleep
from sys import exit
import usb_hid
import board

led = dgio.DigitalInOut(board.LED)
button = dgio.DigitalInOut(board.GP0)
listener = dgio.DigitalInOut(board.GP1)
button.direction = dgio.Direction.OUTPUT
listener.direction = dgio.Direction.INPUT
led.direction = dgio.Direction.OUTPUT

def off():
    for i in range(1, 5):
        led.value = True
        sleep(0.09)
        led.value = False
        sleep(0.09)


for s in range(1, 3):
    if listener.value: # read the button value for a while
        off()
    	exit()
    sleep(1)

keyboard = Keyboard(usb_hid.devices)
layout = KeyboardLayoutUS(keyboard)



def error():
    for i in range(1, 8):
        led.value = True
        sleep(1)

cmds = ''

try:
    file = open('commands.txt', 'r')
except:
    error()
    exit()
else:
    cmds = file.read()

keyboard.send(Keycode.CONTROL, Keycode.ALT, Keycode.T) # open a terminal(linux, OSX)
sleep(4)
layout.write(cmds+"\n")
