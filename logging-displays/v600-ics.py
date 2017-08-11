from icalendar import Calendar, Event
import shutil
import requests
import arrow

#################################################################
# Get resource ics file from reservaiton system
url = 'http://192.168.192.47/booked/Web/export/ical-subscribe.php?uid=&sid=&rid=58ecd1203323b&icskey=nmr'
response = requests.get(url, verify=False, stream=True) # dont verify ssl certs as I'm using self signed.
with open('/tmp/v600.ics', 'wb') as out_file:
    shutil.copyfileobj(response.raw, out_file)
del response
#################################################################
now = arrow.now()#.format('YYYY-MM-DDTHH:mm:ssZZ')# get time now
g = open('/tmp/v600.ics','rb')# open ics file for reading
gcal = Calendar.from_ical(g.read()) #read ics file
#print "starting"
file_v600 = open("/home/pi/reservations/v600.txt", "w") # open reservations txt file for write
file_v600.write('Varian 600 - Upcoming Reservations'+'\n') #write
file_v600.write('Last update: '+now_text +'\n')#write
for component in gcal.walk():# loop through all events
    if component.name == "VEVENT":# loop through all events
        Summary = component.get('summary') # get summary
        end = component.get('dtend') # get reservation end time
        end_time = arrow.get(end.dt).replace(tzinfo='UTC') # arrow object add tzinfo
        if end_time > now: # if ending time is later than now
            file_v600.write(Summary+'\n')# then write info to txt file.
            #print component.get('summary')
g.close() # close ics file
file_v600.close() # close txt file
