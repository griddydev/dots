#!/bin/sh

pkill -f gsd-media-keys   # add this line near the top
pkill lxpolkit
lxpolkit &


slstatus -s | dwl -s "dwl_startup &"
