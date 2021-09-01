#!/usr/bin/bash

ROOT_PICO_PATH="/media/$(whoami)/CIRCUITPY"
SECONDS=10

if [ -d "$ROOT_PICO_PATH/lib/adafruit_hid/" ]
then
  echo -e "\e[0;36madafruit_hid is installed on pico ✅"
else

  if [ -d "Adafruit_CircuitPython_HID/adafruit_hid" ]
  then
    echo -e "\e[0;32mAdafruit_CircuitPython_HID is cloned ✔️"
  else
    printf  "\e[0;31mAdafruit_CircuitPython_HID doesn't exist. Installing "
    for i in {1..5}
    do
      printf "."
      sleep 0.1
    done
    git clone https://github.com/adafruit/Adafruit_CircuitPython_HID.git
    echo -e "\n\e[0;32mInstalled successfully ✔️"
  fi

  if [ -d $ROOT_PICO_PATH ]
  then
    echo -e "\e[0;36mcopying the library to pico"
    cp  -r Adafruit_CircuitPython_HID/adafruit_hid/ "$ROOT_PICO_PATH/lib"
    rm -rf Adafruit_CircuitPython_HID
  else
    echo -e "\e[0;31mPICO ISN'T CONNECTED!"
    exit
  fi

fi


if [ -d $ROOT_PICO_PATH ]
then
  echo -e "\e[1;33m🔴 Copying the code🔴"
  cp code.py $ROOT_PICO_PATH
  cp commands.txt $ROOT_PICO_PATH
else
  echo -e "\e[1;31mPico is not connected. Please connect the bord and try again"
  exit
fi

echo -e "\e[1;36mUnmounting..."

MOUNTPOINT=$(df -P $ROOT_PICO_PATH | tail -1 | cut -d' ' -f 1)

sudo eject $MOUNTPOINT

echo -e "\e[1;33m⚠⚠️⚠️⚠️\nUSB is ready to use. Make sure to press the kill switch before you plug into your main device.\n⚠⚠️⚠️⚠️"
