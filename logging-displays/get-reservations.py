import mechanize
from bs4 import BeautifulSoup
import urllib2
import cookielib
import re
import sys
import markup
import time

now = time.strftime("%H:%M %x")

url = "https://www3.nd.edu/~nmr/scheduling/"
user = "jpontius"
pwd = ""
cj = cookielib.CookieJar()
br = mechanize.Browser()
br.set_handle_robots(False)
br.set_handle_refresh(mechanize._http.HTTPRefreshProcessor(), max_time=1)
br.addheaders = [('User-agent', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008071615 Fedora/3.0.1-1.fc9 Firefox/3.0.1')]
br.set_cookiejar(cj)


# If the protected site didn't receive the authentication data you would
# end up with a 410 error in your face
br.add_password(url, user, pwd)


response1 = br.open(url).read()


for link in br.links(text_regex='Resource'):
    print '' #link.text, link.url

br.follow_link(link)
#print(br.geturl())



# for form in br.forms():
#     print "Form name:", form.name
#     print form

br.select_form("SignupForm")
# for control in br.form.controls:
#     print control
#     print "type=%s, name=%s value=%s" % (control.type, control.name, br[control.name])

response = br.submit()
#print response.read()
soup = BeautifulSoup(response)
#print(soup.prettify())

tags = soup.find_all(href=re.compile("resource=6"))
# print 'Bruker 500'
# result = ''
# for eachtags in tags:
# 	print eachtags.string
# 	#result = result + tags[eachtags]
file500 = open("/home/justin/reservations/500.txt", "w")
file500.write('Bruker 500 - Upcoming Reservations'+'\n')
file500.write('Last update: '+now +'\n')
for eachtags in tags:
    file500.write(eachtags.string+'\n')
file500.close()


print ''
tags = soup.find_all(href=re.compile("resource=5"))
file400 = open("/home/justin/reservations/400.txt", "w")
file400.write('Bruker 400 - Upcoming Reservations'+'\n')
file400.write('Last update: '+now +'\n')
for eachtags in tags:
    file400.write(eachtags.string+'\n')
file400.close()


print ''
tags = soup.find_all(href=re.compile("resource=4"))
# print 'Varian 600'
#
# for eachtags in tags:
# 	print eachtags.string
filev600 = open("/home/justin/reservations/v600.txt", "w")
filev600.write('Varian 600 - Upcoming Reservations'+'\n')
filev600.write('Last update: '+now +'\n')
for eachtags in tags:
    filev600.write(eachtags.string+'\n')
filev600.close()


print ''
tags = soup.find_all(href=re.compile("resource=3"))
# print 'Varian 500'
#
# for eachtags in tags:
#  	print eachtags.string
filev500 = open("/home/justin/reservations/v500.txt", "w")
filev500.write('Varian 500 - Upcoming Reservations'+'\n')
filev500.write('Last update: '+now +'\n')
for eachtags in tags:
    filev500.write(eachtags.string+'\n')
filev500.close()

print ''
tags = soup.find_all(href=re.compile("resource=7"))
# print 'Bruker 800'
#
# for eachtags in tags:
# 	print eachtags.string
file800 = open("/home/justin/reservations/800.txt", "w")
file800.write('Bruker 800 - Upcoming Reservations'+'\n')
file800.write('Last update: '+now +'\n')
for eachtags in tags:
    file800.write(eachtags.string+'\n')
file800.close()

print ''
tags = soup.find_all(href=re.compile("resource=1"))
# print 'JEOL 300'
#
# for eachtags in tags:
#         print eachtags.string
file300 = open("/home/justin/reservations/300.txt", "w")
file300.write('JEOL/SS 300 - Upcoming Reservations'+'\n')
file300.write('Last update: '+now +'\n')
for eachtags in tags:
    file300.write(eachtags.string+'\n')
file300.close()

print 'Done.'
