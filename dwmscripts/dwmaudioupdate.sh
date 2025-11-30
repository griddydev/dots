audio_level=$(pamixer --get-volume)
audio_mute=$(pamixer --get-mute)

if [ $audio_mute == "true" ]
then
	audio_icon=""
	echo $audio_icon > /home/qwe/code/desktopenvironment/dwmscripts/dwmaudio.txt
else
	if [ $audio_level -gt 40 ]
	then
		audio_icon=""
	elif [ $audio_level -gt 10 ]
	then
		audio_icon=""
	else
		audio_icon=""
	fi
	echo $audio_icon $audio_level > /home/qwe/code/desktopenvironment/dwmscripts/dwmaudio.txt
fi

dwmbarfast

