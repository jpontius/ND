#!/bin/bash

#echo "sleeping for 3 seconds"
sleep 3
# Transfer to my desktop for rules check.
#rsync -r -z --timeout=10 /home/pi/reservations/ justin@129.74.143.229:/home/justin/res-check/

#Transfer to logging displays.
rsync -r -z --timeout=10 /home/pi/reservations/ pi@nmr500b-log.campus.nd.edu:/home/pi/reservations
rsync -r -z --timeout=10 /home/pi/reservations/ pi@nmr2a-log.campus.nd.edu:/home/pi/reservations
rsync -r -z --timeout=10 /home/pi/reservations/ pi@nmr600-log.campus.nd.edu:/home/pi/reservations
rsync -r -z --timeout=10 /home/pi/reservations/ justin@nmr800-ups.campus.nd.edu:/home/justin/reservations
#rsync -r -z --timeout=10 /home/pi/reservations/ pi@raspberry.campus.nd.edu:/home/pi/reservations


#echo "done"
