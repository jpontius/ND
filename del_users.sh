#!/bin/bash

while read u; do

# Test that the NetID is the valid University NetID

/bin/grep -w "$u" /afs/nd.edu/common/etc/passwd 
if [ "$u" -ne 0 ]     
   then 
       echo "Error: NetID: <" $NetID "> is not valid. Please specify a valid Notre Dame NetID."
       echo "$NetID" >> bad-NetID.txt
      exit
fi       

done < users.txt
