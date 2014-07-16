#!/bin/bash

while read user; do

# Test that the NetID is the valid University NetID

/bin/grep -w "$user" /afs/nd.edu/common/etc/passwd
if [ "$user" -ne 0 ]
   then
       echo "Error: NetID: <" $user "> is not valid. Please specify a valid Notre Dame NetID."
       echo "$user" >> bad-NetID.txt
      exit
fi

done < users.txt
