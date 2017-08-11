import feedparser
import html2text

d = feedparser.parse('webcal://nmr-res.chem.nd.edu/booked/Web/export/ical-subscribe.php?uid=&sid=&rid=58ecd1203323b&icskey=nmr')

print d['feed']['title']
print d['feed']['link']
print len(d['entries'])
print d['entries'][0]['summary']
html = d['entries'][0]['summary']
print html2text.html2text(html)
