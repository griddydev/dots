#!/bin/bash


rtemp=$(sensors | grep ctl | grep -Eo '[0-9.]+')
#rtemp=$(sensors | awk 'NR==7{print $2}')
#rtemp=$(sensors | awk 'NR==26{print $2}')
temp="${rtemp//[+]/}"
#rgtemp=$(sensors | awk 'NR==5{print $2}')
#rgtemp=$(sensors | awk 'NR==12{print $2}')
#rgtemp=$(sensors | awk 'NR==16{print $2}')
#gtemp="${rgtemp//[+]/}"
icon=

printf " %s %s \\n" "$icon" "$temp"

#printf " %s%s  %s %s \\n" "$icon " "$temp" "$icon" "$gtemp"
