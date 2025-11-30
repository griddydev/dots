#!/bin/bash

#WEATHER = ICON 69C

#ICON

rtnow="$(date | awk '{print $4}')"
tnow="${rtnow//[!0-9]/}"
 
rsset="$(curl wttr.in/94133?format=%d)"
sset="${rsset//[!0-9]/}"

rsriz="$(curl wttr.in/94133?format=%D)"
sriz="${rsriz//[!0-9]/}"

rwicon="$(curl wttr.in/94133?format=%C)"
wicon="${rwicon//[[:blank:]]/}"
#Weather Types
Clear="Clear"
Sunny="Sunny"

Fog="Fog"
Overcast="Overcast"
Mist="Mist"
Haze="Haze"
Smoke="Smoke"
Cloudy="Cloudy"
Shallowfog="Shallowfog"
Freezingfog="Freezingfog"
Thunderyoutbreakspossible="Thunderyoutbreakspossible"
SmokeIcon=" "
fmoon1=""
fmoon2=""
fmoon3=""

Thunderstorminvicinity="Thunderstorminvicinity"

if [ $tnow -gt $sriz ] && [ $tnow -lt $sset ]
###then
###	if [ "$wicon" = "$Fog" -o "$wicon" = "$Haze" -o "$wicon" = "$Overcast" -o "$wicon" = "$Thunderstorminvicinity" -o "$wicon" = "$Mist" -o "$wicon" = "$Shallowfog" -o "$wicon" = "$Cloudy" -o "$wicon" = "$Freezingfog" -o "$wicon" = "$Thunderyoutbreakspossible" ]	
###	then
###		icon=""
###	elif [ "$wicon" = "$Sunny" -o "$wicon" = "$Clear" ]
###	then
###		icon=""
###	elif [ $wicon == $Smoke ]
###	then
###		icon=""
###	else
###		icon="$(curl wttr.in/94133?format=%c)"
###	fi
###elif [ $wicon == $Clear ] || [ $wicon == $Sunny ]
then
	MPHAZ="$(curl wttr.in/94102?format=%M)"
	if [ $MPHAZ -lt 2 ]
	then
		icon="🌕"
	elif [ $MPHAZ -lt 7 ]
	then
		icon="🌖"
	elif [ $MPHAZ -lt 10 ]
	then
		icon="🌗"
	elif [ $MPHAZ -lt 13 ]
	then
		icon="🌘"
	elif [ $MPHAZ -lt 14 ]
	then
		icon="🌑"
	elif [ $MPHAZ == 14 ]
	then
		icon=""
	elif [ $MPHAZ -lt 16 ]
	then
		icon="🌑"
	elif [ $MPHAZ -lt 20 ]
	then
		icon="🌒"
	elif [ $MPHAZ -lt 23 ]
	then	
		icon="🌓"
	elif [ $MPHAZ -lt 26 ]
	then
		icon="🌔"
	else
		icon="🌕"
	fi
else
	icon=""
fi

##Temperature - I'm using darksky to get the temperature because wttr.in has some issue rn...I opened an issue on their github and if/when it gets fixed I'll go back to using it but for now I need to know the temperature outside

##as of 10/9/22 im goin back to wttr.in for temp because darksky has some error atm and I see they're forcing people off their service anyways...if wttr.in continues to give incorrect info I will hack together another source via digitextractor + newv source

##curl https://darksky.net/forecast/37.7794,-122.4184/si10/en > darksky.html
##
##EX="$(cat darksky.html | grep 'summary swap')"
##
##temp="$(echo $EX | digitextractor)"
##
##rm darksky.html
##

## This is the wttr.in method which I like but it never has the correct temperature for some reason
#rctemp="$(curl -s 'wttr.in?m&format=%t')"
#rftemp="$(curl -s 'wttr.in?format=%t')"
#
#
#freeze="31"
#ctemp="${rctemp//[!0-9]/}"
#ftemp="${rftemp//[!0-9]/}"
#
#if [ $ftemp -lt $freeze ]
#then
#	temp="- $ctemp"
#else
#	temp="$ctemp"
#fi

##as of 10/11/22 this is the method I'm using. I semi-modified digitextractor but I think awk and grep could do the same thing...it does work tho so whatevs

temp="$(curl 'https://forecast.weather.gov/MapClick.php?textField1=37.8&textField2=-122.41' | grep 'current-sm' | weatherdigitextractor)"

printf " %s%s \\n" "$icon " "$temp"


