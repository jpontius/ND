#!/bin/bash

while read u; do
#  echo $u
  /home/justin/add_afs800 $u
done < users.txt

