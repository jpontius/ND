#!/bin/bash

cd /billing/User_Management
mv not_in_billing.txt not_in_billing.txt.old

# Get current users in system
getent passwd | grep -vE '(nologin|false)$' | awk -F: -v min=1000 -v max=9999999 '{if(($3 >= min)&&($3 <= max)) print $1}' | sort -u > system_users

# Get current user account list.
wget -qO - http://www3.nd.edu/~jpontius/users/users.csv > users.csv
cat users.csv | cut -d "," -f1 > user_list


# Outputs list of users not in billing 'users.csv'
grep --invert-match -wFf user_list system_users > not_in_billing.txt

# Check if files are different.
cmp --silent not_in_billing.txt not_in_billing.txt.old || /usr/local/bin/swaks --from nmr@nd.edu --to jpontius@nd.edu --h-Subject "Notification from $HOSTNAME" --body "Billing users are different from actual users on $HOSTNAME." --attach-type "text/plain" --attach /billing/User_Management/not_in_billing.txt -n --silent 3
