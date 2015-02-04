#!/bin/bash

cd /billing
mv users_not_in_billing.txt users_not_in_billing.txt.old

# Get current users in system
system_users=$(cat /etc/passwd | cut -d ":" -f1)

# Get current user account list.
wget -qO - http://www3.nd.edu/~jpontius/users/users.csv > users.csv
user_list=$(cat users.csv | cut -d "," -f1)

# Outputs list of users not in billing 'users.csv'
grep --invert-match -wFf "$user-list" "$system_users" > users_not_in_billing.txt

# Check if files are different.
#file1=$(md5 users_not_in_billing.txt)
#file2=$(md5 users_not_in_billing.txt.old)

#if [ "$file1" == "$file2" ]
#then
#    echo "Files have the same content"
#else
#    echo "Files have NOT the same content"
#fi