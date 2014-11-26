#!/bin/sh

DATE=$(date +"%m-%d-%Y %H:%M")
#TIME=$(date +"%H:%M")
#user=$($USER)

#if [[ "$USER" -eq jpontius || $USER -eq nmrsu || $USER -eq jzajicek ]]; then
#       exit 0
#fi

useracct=$(wget -qO - http://www3.nd.edu/~jpontius/users/users.csv | grep "$USER" | cut -d',' -f3)
totaltime=$(last | grep $USER | head -n 1 | awk '{ print $10; }')
account=$(zenity --height 300 --width 400 --entry --title="Account Number" --text="Enter your FOP Account" --entry-text "$useracct"  )
nuc=$(zenity --height 300 --width 400 --list --checklist \
        --title="Nuclus" --column "Select" --column "NUC" \
        TRUE 1H FALSE 13C FALSE 31P FALSE 11B FALSE 29Si FALSE 2H FALSE 15N FALSE 17O FALSE 19F FALSE Other )
#       | nawk '{print substr($0,1,10)}' )

solvent=$(zenity --height 300 --width 400 --list --checklist \
        --title="Solvent" --column "Select" --column "Solvent" \
        TRUE Chloroform-d FALSE Acetone-d6 FALSE Benzene-d6 FALSE DCM FALSE Toluene-d8 FALSE D2O FALSE DMSO FALSE Other )
        #| nawk '{print substr($0,1,23)}' )

zenity --height 300 --width 400 --question --text="\\r Did you use Variable Temperature? \\r\\r OK=Yes \\r Cancel=No"; vt=$?

if [ "$vt" = "1" ]; then
  vt=No
elif [ "$vt" -ne "1"  ]; then
  vt=$(zenity --height 300 --width 400 --entry --text="Enter max Temperature in C." --entry-text "22");
fi

zenity --height 300 --width 400 --question --text "Did you have any problem with the instrument?  \\r\\r OK=Yes \\r Cancel=No"; problem=$?
if [ "$problem" = 0 ]; then
 
 comment=$(zenity --height 300 --width 400 --entry --title="Comments" --text="Please enter a brief discription of the problem");
 comment2=$(echo -e "$comment");
 echo "There was a problem on $HOSTNAME $DATE, $totaltime, $USER, $account, $nuc, $solvent, $vt, $comment2" | nail -A gmail -s "Log notification from Bruker 500" -a /log/user.log -S ttycharset=iso-8859-1 jpontius@nd.edu &
 zenity --height 300 --width 400 --info --text 'Thanks, NMR Staff has been notified of your issue.'

 else
   #statements
   #problem=0;
  comment2='None';
  
fi

printf '%b\n' "$DATE","$totaltime","$USER","$account","$nuc","$solvent","$vt","$comment2" >> /log/user-600.log
printf '%b\n' "$DATE $totaltime $USER $account $nuc $solvent VT=$vt $comment2" >> /log/user-600-2.log
printf "No one is using the NMR  :(" > /log/in.log
scp /log/*.log justin@nmr800-ups.campus.nd.edu:/home/justin/log &


if [ "$account" -ne "$useracct" ]; then
        echo "User $USER entered a different account number.  $account vs $useracct" | nail -A gmail -s "Log notification from Varian 600" jpontius@nd.edu &
fi


exit 0

