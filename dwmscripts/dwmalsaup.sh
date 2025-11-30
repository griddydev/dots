#!/bin/bash

amixer set Master 5%+


alevel=$(amixer | awk 'NR==6 {print $5}')
alevel="${alevel//[!0-9]/}"
atoken=$(amixer | awk 'NR==6 {print $6}')
atoken="${atoken//[}"
atoken="${atoken//]}"
off="off"

if [ $atoken == $off ]
then
	aicon=""
	echo $aicon > /home/qwe/code/desktopenvironment/dwmscripts/dwmalsa.txt
else
	if [ $alevel -gt 50 ]
	then
		aicon=""
	elif [ $alevel -gt 10 ]
	then
		aicon=""
	else
		aicon=""
	fi
	echo $aicon $alevel > /home/qwe/code/desktopenvironment/dwmscripts/dwmalsa.txt
fi

dwmbarfast

