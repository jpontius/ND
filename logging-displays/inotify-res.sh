#!/bin/bash
while true #run indefinitely
do
#inotifywait -r -e close_write /home/pi/reservations && cp /home/pi/reservations/*.txt /home/pi/info-beamer-pi/NMR/res/
inotifywait -r -e close_write /home/pi/reservations && cat /home/pi/reservations/400.txt | head -n 12  > /home/pi/info-beamer-pi/NMR/res/400.txt

done
