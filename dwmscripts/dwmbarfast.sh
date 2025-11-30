#!/bin/bash
WEATHER=$(< /home/qwe/code/desktopenvironment/dwmscripts/dwmweather.txt)
UPDATES=$(< /home/qwe/code/desktopenvironment/dwmscripts/dwmupdates.txt)
TEMP=$(dwmtemp)
RAM=$(dwmram)
DISK=$(< /home/qwe/code/desktopenvironment/dwmscripts/dwmdisk.txt)
AUDIO=$(< /home/qwe/code/desktopenvironment/dwmscripts/dwmaudio.txt)
DATE=$(date +%a\ %b%d\ %R)
xsetroot -name " $DISK | $RAM | $TEMP | $UPDATES | $WEATHER | $AUDIO | $DATE"
