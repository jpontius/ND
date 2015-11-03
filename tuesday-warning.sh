#!/bin/bash

export DISPLAY=:0.0

DAYOFWEEK=$(date +"%u")
time=$(date +%k%M)

#echo DAYOFWEEK: $DAYOFWEEK
#echo Time: $time

if [[ "$DAYOFWEEK" == 2 ]] && [[ "$time" -ge 900 ]] ;
then
   zenity --error --text "The diffusion probe is installed.\n \nThis probe is not suitable for normal experiments.\n \nPlease contact NMR staff for assistance."
elif [[ "$DAYOFWEEK" == 3 ]] && [[ "$time" -le 900 ]] ;
then
  zenity --error --text "The diffusion probe is installed.\n \nThis probe is not suitable for normal NMR experiments.\n \nPlease contact NMR staff for assistance."
else
  exit 0
fi
