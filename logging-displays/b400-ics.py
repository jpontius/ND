from icalendar import Calendar, Event
import shutil
import requests
import arrow

url = 'http://192.168.192.47/booked/Web/export/ical-subscribe.php?uid=&sid=&rid=58ecd28916533&icskey=nmr'
response = requests.get(url, stream=True)
with open('/tmp/400.ics', 'wb') as out_file:
    shutil.copyfileobj(response.raw, out_file)
del response


now = arrow.now()#.format('YYYY-MM-DDTHH:mm:ssZZ')
now_text = arrow.now().format('HH:mm MM-DD-YYYY')
g = open('/tmp/400.ics','rb')
gcal = Calendar.from_ical(g.read())
print "starting"
file400 = open("/home/pi/reservations/400.txt", "w")
file400.write('Bruker 400 - Upcoming Reservations'+'\n')
file400.write('Last update: '+now_text +'\n')
for component in gcal.walk():
    if component.name == "VEVENT":
        Summary = component.get('summary')
        start = component.get('dtstart')
        start_time = arrow.get(start.dt).replace(tzinfo='UTC')# 'YYYY-MM-DDThh:mm:ss+SS:SS')#.replace(tzinfo='UTC')
        start_time = start_time.to('US/Eastern')

        end = component.get('dtend')
        end_time = arrow.get(end.dt).replace(tzinfo='UTC')

        if end_time > now:
            file400.write(Summary+'\n')
            print component.get('summary')
        # if start_time > now:
        #     file400.write(Summary+'\n')
        #     print component.get('summary')
        # component.get('location'),
        # print component.get('dtstart')

g.close()
file400.close()
