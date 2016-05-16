#!/bin/bash

SAVEDIR=/var/www/stills
#SAVEDIR=/mnt/usb/stills
WEBDIR=/var/www
filename=%04d-$(date -u +"_%d%m%Y_%H%M-%S").jpg
videofilename=$(date -u +"%d%m%Y_%H%M-%S").avi
Hours=$1
Secs=$2
Quality=75
#$APIKEY= <insert your prowl key here>

Length=$((3600000 * Hours))
#Length=$((10000 * Hours))
Frequency=$((1000 * Secs))
http-server $WEBDIR &
echo $Length
echo $Frequency


#Take the pictures

/opt/vc/bin/raspistill -q $Quality -t $Length -tl $Frequency -o $SAVEDIR/$filename

#Write the list of files to a text file
ls $SAVEDIR/*.jpg > stills.txt

#Encode it
mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1920:1080 -o $WEBDIR/$videofilename -mf type=jpeg:fps=24 mf://@stills.txt
python /home/pi/uploader.py /home/pi/uploader.cfg $WEBDIR/$videofilename

#prowl it 
#curl https://prowl.weks.net/publicapi/add -F apikey=$APIKEY -F application="PiLapse" -F event="TimeLapse Done" -F description="TimeLapseDone"

#Remove the files
rm $SAVEDIR/*.jpg
