#!/bin/bash
cd /home/justin/res-check/
# Get rule txt and put in variable.
cat /mnt/nmr-netfile/www/scheduling/data/resources.csv | grep "Bruker 500 Spectrometer" | cut -d "\"" -f 2 | cut -d "<" -f 1 > b500-rules.txt

grep -E 'Mon|Tue|Wed|Thu|Fri|Sat' 500.txt | while IFS='' read -r line || [[ -n "$line" ]]; do
    # Set variables.
    start_time=$(echo "$line" | cut -d " " -f 11)
    start_hour=$(echo "$start_time" | cut -d ":" -f 1 | awk '$1!~/[^0-9]/' | sed 's/^0*//')
    start_min=$(echo "$start_time" | cut -d ":" -f 2 | awk '$1!~/[^0-9]/')
    end_time=$(echo "$line" | cut -d " " -f 13)
    end_hour=$(echo "$end_time" | cut -d ":" -f 1 | awk '$1!~/[^0-9]/' | sed 's/^0*//')
    end_min=$(echo "$end_time" | cut -d ":" -f 2 | awk '$1!~/[^0-9]/')
    username=$(echo "$line" | cut -d "-" -f 2 | sed 's/^[\t ]*//g' | sed 's/[ \t]*$//' )
    username_first=$(echo "$username" | cut -d " " -f 1 )
    username_last=$(echo "$username" | cut -d " " -f 2 )

    # Fix end hour due to overnight dates messing up coloums in file.
    if ! [[ $end_hour =~ ^[0-9]+$ ]]
      then end_hour=24
    fi

    # Start checking during restriced hours.
    if [ $start_hour -lt 17 ] && [ $start_hour -gt 08 ] || [ $start_hour -gt 07 ] && [ $end_hour -lt 17 ]
    then
      # Get total minutes of reservation.
      res_minutes=$((start_min-end_min))
      res_hours=$((start_hour-end_hour))
      # Correct minutes if 2 different hours
      if [ $res_minutes -gt 15 ] || [ $res_minutes -eq 0 ] || [ $res_hours -lt 0 ]
        then res_minutes=$((res_minutes-60))
      fi
      # useremail=$(cat /mnt/nmr-netfile/www/scheduling/data/userlist.csv | grep "$username_last, $username_first" | cut -d "," -f 6 | sed 's/^[\t ]*//g' | sed 's/[ \t]*$//' )
      # echo "$useremail"
      # Since the minutes are negative, if minutes are greater than -15 then PROBLEM. Also check for NMR account.
      if [ "$username" != "NMR" ] && [ $res_minutes -lt -15 ]
        then
        useremail=$(cat /mnt/nmr-netfile/www/scheduling/data/userlist.csv | grep "$username_last, $username_first" | cut -d "," -f 6 | sed 's/^[\t ]*//g' | sed 's/[ \t]*$//' )
        #echo "BINGO: $username_last, $username_first, $useremail is bad."
        /usr/local/bin/swaks -t $useremail,jpontius@nd.edu -f nmr@nd.edu  --header "Subject: NMR Scheduling rule violation" --body "You are violating the Bruker 500 scheduling rules.  Please correct this immediately.  https://www3.nd.edu/~nmr/scheduling/index.php  \n\n$line" --attach /mnt/nmr-netfile/www/500-1.png --attach b500-rules.txt --server nmr-camera.campus.nd.edu --silent 2
      fi
    fi
done
