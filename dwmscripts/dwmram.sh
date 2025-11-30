#!/bin/bash

rram=$(free -h | awk 'NR==2{print $3}')
ram="${rram//i}"
icon=""

printf " %s%s \\n" "$icon " "$ram"
