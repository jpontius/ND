ND
==

work stuff

# output all users on existing sytem to a file.

```cat /etc/passwd | awk -F: '{ print $1 }' > /home/justin/users.txt```

# copy users.txt to new system
```bash
scp /home/justin/users.txt justin@XXXX:/home/justin
```

# run bash script on new system
```bash
#!/bin/bash

while read u; do
#  echo $u
  /home/justin/add_afs800 $u
done < users.txt
```