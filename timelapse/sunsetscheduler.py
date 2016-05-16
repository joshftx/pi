#This script will calculate the sunset time, and start an 
#at job  which starts a timelapse one hour before

import os
import urllib
import json
url = 'http://api.wunderground.com/api/97bbf555c12a2e71/astronomy/q/CA/San_Francisco.json'
result = json.load(urllib.urlopen(url))

hour = result ["sun_phase"]["sunset"]["hour"]
min = result ["sun_phase"]["sunset"]["minute"]

startHour = int(hour) -1
startTime = '%s:%s' %(startHour,min)

command = "at -f /home/pi/pi/time.sh " + startTime
os.system(command)
