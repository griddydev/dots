#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#CLIPMENU
systemctl --user import-environment DISPLAY

#Swap left Alt and Meta for the X session
setxkbmap -option altwin:swap_alt_win

#Swap right CTRL for right ALT for this X session]
setxkbmap -option 'ctrl:rctrl_ralt'

#CLIPMENU DAEMON
clipmenud &

#Udiskie boot daemon (auto mount USB)
udiskie &

#DWM BAR
dwmbar &

#Load Background
~/.fehbg &

#Redshift
redshift -l 37.46:-122.26 &

#WINDO MANAGER == DWM
exec dwm


