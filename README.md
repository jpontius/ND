Work stuff
==

Ansible command to add topspin users to all topspin hosts.
129.74.143.27
```bash
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
