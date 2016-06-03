#!/bin/bash

###  This script will check our scheduling systems userlist.csv file for corruption against a backup [userlist.csv.JUSTIN].  ###

cd /mnt/nmr-netfile/www/scheduling/data

USERLIST_ORG=$(wc -l userlist.csv | awk '{print $1}')
USERLIST_BAK=$(wc -l userlist.csv.JUSTIN | awk '{print $1}')

# echo "ORG: $USERLIST_ORG"
# echo "BAK: $USERLIST_BAK"

if [ "$USERLIST_ORG" -ne "$USERLIST_BAK" ]
  then
    /usr/local/bin/swaks --to jpontius@nd.edu --from nmr@nd.edu --h-Subject "Userlist file corrupted"  --body "The Userlist file was corrupted, coping from backup." --add-header "MIME-Version: 1.0" --add-header "Content-Type: text/html" --server nmr-camera.campus.nd.edu --silent 3
    cp userlist.csv.JUSTIN userlist.csv
  fi
