import urllib, json
import sys
import urlparse
import requests
import math
import csv
import os

uid = str(sys.argv)
netid = sys.argv[1]

url = "http://ur.nd.edu/request/eds.php?uid={}".format( netid )
#A = json.load(urllib.urlopen(url))

userlist = csv.DictReader(open('/mnt/nmr-netfile/www/scheduling/data/userlist.csv'))

max_usn = None
for row in userlist:
    usn = int(row["usn"])
    if max_usn == None or max_usn < usn:
        max_usn = usn

if max_usn != None:
    new_usn = max_usn + 1
    #print new_usn
else:
    #print "Error reading USN from userlist.csv."
    raise Error("Error reading USN from userlist.csv.")

total_line2 = str(new_usn)

r = requests.get(url)

uid = r.json()['uid']
telephonenumber = r.json()['telephonenumber']
mail = r.json()['mail']
sn = r.json()['sn']
givenname = r.json()['givenname']


uid2 = str(uid)
telephonenumber2 = str(telephonenumber)
mail2 = str(mail)
sn2 = str(sn)
givenname2 = str(givenname)

with open('/mnt/nmr-netfile/www/scheduling/data/userlist.csv', "a") as userlist:
    userlist.write(total_line2 + ", " + sn2 + ", " + givenname2 + ", " + "1, " + "WT8jZYnOTSTbo, " + mail2 + ", " + ", " + "b0000000, " + ", " + uid2 + ", " + ", " + telephonenumber2 + ", " + "\n")

with open('/mnt/nmr-netfile/www/.htgroup', "a") as htgroup:
    htgroup.write("userlist: " + uid2 + "\n")

os.system("/usr/local/bin/swaks --to " + mail + ",jpontius@nd.edu, --from nmr@nd.edu --h-Subject 'NMR Account' --body 'User " + givenname2 + " " + sn + " [" + uid2 +"] has been added to the Bruker NMR system.' --add-header 'MIME-Version: 1.0' --add-header 'Content-Type: text/html' --server nmr-camera.campus.nd.edu")
