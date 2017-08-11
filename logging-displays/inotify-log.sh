#!/bin/bash
while true #run indefinitely
do
inotifywait -r -e close_write /home/pi/log && tac /home/pi/log/nmr400b.log | head -n 25 > /home/pi/info-beamer-pi/NMR/log/log.txt
done
