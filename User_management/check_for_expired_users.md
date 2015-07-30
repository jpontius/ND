##Test for expired NMR users.

This script will give a list of users failing an LDAP lookup based on an infile.  Do something like
```bash test_for_bad_user.sh scheduling-users.txt > scheduling-users_FOUND_BAD.txt```

```bash

#!/bin/sh

url="ldap://directory.nd.edu"
basedn="ou=people,dc=nd,dc=edu"

for i in `cat $1`; do
    if ldapsearch -x -H "$url" -b "$basedn" uid=$i | grep -e "uid:"  > /dev/null
    then
        # Do nothing
        true
    else
        echo $i
    fi
done
```


####Then match that list with the scheduling users in userlist.csv.
This will remove users from the scheduling website.

```grep -vif scheduling-users_FOUND_BAD.txt /mnt/nmr-netfile/www/scheduling/data/userlist.csv```

####Disable users from workstations with Ansible.

```bash
#!/bin/sh
for i in `cat $1`; do
  ansible topspin -a "usermod -s /sbin/nologin $i"
done
```

```sudo bash ansible_disable_users.sh scheduling-users_FOUND_BAD.txt```
