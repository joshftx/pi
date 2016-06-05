# pi
Raspberry Pi Projects

TimeLapse

requirements:
raspbian jessie
python
at
mencoder
anacron

This project will calculate the sunset each day, set a cron job which starts one hour before sunset and takes a timelapse using the pi's camera until one hour after sunset. When it finishes, mencoder is used to create a movie. Options inclde a prowl alert and a google drive uploader.  

Make sure you update the directory paths in all the scripts.

sunsetcheduler.py
This is a python script which will calculate the next sunset time and schedule an at job to start the timelapse one hour before sunset and until 1 hour after sunset.  

You may need to 'apt-get install at' if you don't have it already.
I uses anacron to schedule a daily job which will fire off the sunsetscheduler once a day. 
apt-get install anacron' 

time.sh 
this is a oneliner which launches the actual timelapse.sh script

timelapse.sh
THis script is the one which does all the work. THere's a few directory variables to set. It accepts two arguments - the first is the number of hours to run, and the second is the snapshot interval.  So, running 'sh timelapse.sh 2 5' will run for two hours snapping a pic every 5 seconds.

At the end of the run, mencoder is called and crunches all the pictures into a video, and deletes the jpgs.  WARNING: mencoder was tricky to get installed on the latest raspbian on my pi3.  

