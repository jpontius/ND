from icalendar import Calendar, Event
import shutil
import requests
import arrow

#################################################################
# Get resource ics file from reservaiton system
url = 'http://192.168.192.47/booked/Web/export/ical-subscribe.php?uid=&sid=&rid=58ed20a8c39c6&icskey=nmr'
response = requests.get(url, verify=False, stream=True) # dont verify ssl certs as I'm using self signed.
with open('/tmp/500.ics', 'wb') as out_file:
    shutil.copyfileobj(response.raw, out_file)
del response
#################################################################

now = arrow.now()# get time now
g = open('/tmp/500.ics','rb')# open ics file for reading
gcal = Calendar.from_ical(g.read())#read ics file
#print "starting"
file500 = open("/home/pi/reservations/500.txt", "w")# open reservations txt file for write
file500.write('Bruker 500 - Upcoming Reservations'+'\n')#write
file500.write('Last update: '+now_text +'\n')#write
for component in gcal.walk():# loop through all events
    if component.name == "VEVENT":# loop through all events
        Summary = component.get('summary')# get summary
        end = component.get('dtend')# get reservation end time
        end_time = arrow.get(end.dt).replace(tzinfo='UTC')# arrow object add tzinfo
        if end_time > now:# if ending time is later than now
            file500.write(Summary+'\n')# then write info to txt file.
            #print component.get('summary')
g.close()# close ics file
file500.close()# close txt file
