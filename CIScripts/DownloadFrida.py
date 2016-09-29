import urllib2
import json
import sys
import os
JSON=json.loads(urllib2.urlopen("https://api.github.com/repos/frida/frida/releases/latest").read())
DLURL=None
for Item in JSON['assets']:
	if 'frida-gadget' in Item['name'] and 'ios-universal.dylib' in Item['name']:
		DLURL=Item['browser_download_url']
	else:
		continue

if DLURL==None:
	print "Frida iOS URL Not Found"
	sys.exit(255)
else:
	Data=urllib2.urlopen(DLURL).read()
	x=open("frida-gadget.dylib.xz","w")
	x.write(Data)
	x.close()
	print "Unpacking and remove useless archs"
	os.system("xz -d -f frida-gadget.dylib.xz &&rm ./ExtraFWs/frida-gadget.dylib ||true &&mv frida-gadget.dylib ./ExtraFWs/")
