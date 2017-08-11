#!/bin/bash

/usr/bin/python /home/pi/reservations/b400-ics.py
/usr/bin/python /home/pi/reservations/b500-ics.py
/usr/bin/python /home/pi/reservations/v600-ics.py

/home/pi/reservations/res-sync.sh
