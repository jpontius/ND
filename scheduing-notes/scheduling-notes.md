## Command to clear out old schedules.
# This will mv all *u375.csv* files older than 30 days to tmp storage to insure we don't bork the scheduling system.

```
cd /mnt/nmr-netfile/www/scheduling/data
find . -name 'u[0-9]*.csv' -mtime +30 -exec mv {} /tmp/userlist-files \;
```
