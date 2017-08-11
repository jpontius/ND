from icalendar import Calendar, Event
import shutil
import requests
import arrow

url = 'http://192.168.192.47/booked/Web/export/ical-subscribe.php?uid=&sid=&rid=58ed20a8c39c6&icskey=nmr'
response = requests.get(url, verify=False, stream=True)
with open('/tmp/500.ics', 'wb') as out_file:
    shutil.copyfileobj(response.raw, out_file)
del response


now = arrow.now()#.format('YYYY-MM-DDTHH:mm:ssZZ')
now_text = arrow.now().format('HH:mm MM-DD-YYYY')
g = open('/tmp/500.ics','rb')
gcal = Calendar.from_ical(g.read())
print "starting"
file500 = open("/home/pi/reservations/500.txt", "w")
file500.write('Bruker 500 - Upcoming Reservations'+'\n')
file500.write('Last update: '+now_text +'\n')
for component in gcal.walk():
    if component.name == "VEVENT":
        Summary = component.get('summary')
        start = component.get('dtstart')
        start_time = arrow.get(start.dt).replace(tzinfo='UTC')# 'YYYY-MM-DDThh:mm:ss+SS:SS')#.replace(tzinfo='UTC')
        start_time = start_time.to('US/Eastern')

        end = component.get('dtend')
        end_time = arrow.get(end.dt).replace(tzinfo='UTC')

        if end_time > now:
            file500.write(Summary+'\n')
            print component.get('summary')
        # if start_time > now:
        #     file500.write(Summary+'\n')
        #     print component.get('summary')
        # component.get('location'),
        # print component.get('dtstart')



g.close()
file500.close()
