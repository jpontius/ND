Work stuff
==

Ansible command to add topspin users to all topspin hosts.
129.74.143.27
```bash
su
ansible topspin -a 'sh /root/add_afs800 jpontius'
```

==

Output all users on existing sytem to a file.

```bash
cat /etc/passwd | awk -F: '{ print $1 }' > /home/justin/users.txt
```

Copy users.txt to new system
```bash
scp /home/justin/users.txt justin@XXXX:/home/justin
```

Run bash script on new system
```bash
#!/bin/bash

while read u; do
#  echo $u
  /home/justin/add_afs800 $u
done < users.txt
```

Disable screensaver locking for all users
```bash
gconftool-2 --direct \
--config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool \
--set /apps/gnome-screensaver/lock_enabled false
```

Open all files in a single browser
```bash
gconftool-2 --direct \
> --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool \
> --set /apps/nautilus/preferences/always_use_browser true

```

