#!/bin/bash

#get current netid list
cat users.csv | cut -d "," -f 1 > netid.tmp


url="ldap://directory.nd.edu"
basedn="ou=people,dc=nd,dc=edu"

#check for valid nedid lookup
for i in `cat netid.tmp`; do
    if ldapsearch -x -H "$url" -b "$basedn" uid=$i | grep -e "uid:"  > /dev/null
    then
        # Do nothing
        true
    else
        #output to file
        echo $i
        echo $i >> not-valid.txt
    fi
done
