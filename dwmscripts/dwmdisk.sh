#!/bin/bash

hdd="$(df -h | grep 'nvme0n1p2' | awk  '{print $4}')"
icon=""
printf " %s%s \\n" "$icon " "$hdd"

