#!/bin/bash

#/usr/bin/Xvfb :99 -screen 0 1280x1024x24 -noreset -nolisten tcp &
/usr/bin/Xvfb :99 -screen 0 1024x768x24 -noreset -nolisten tcp &
#/usr/bin/xfwm4 --vblank=off --compositor=off --replace &
/usr/bin/openbox --sm-disable --replace &

# Give X display second so xhost can find it.
sleep 1
disown -h
xhost +local:all

#/usr/bin/x11vnc -forever -display $DISPLAY -auth guess -passwd password &
# echo "password" > ~/.vnc/password
x11vnc -display $DISPLAY -bg -forever -nopw -quiet  -xkb
#-listen localhost
sleep 2
echo "# Start ScreamingFrog ..."

# Set max Java heap 2Gig
# 2022-11-28 -Xdebug seem to make screamingfrog startup more reliable :( ??
echo "-Xdebug -Xmx2g" >> $HOME/.screamingfrogseospider

exec /usr/bin/screamingfrogseospider "$@"
