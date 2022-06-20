#!/bin/bash -p
. /opt/miniconda3/bin/activate topofit
#enter the command you would like to run below or modify this script to be more dynamic
#eg. /topofit/evaluate ...
#eg. /topofit/train ... 
#eg. /topofit/preprocess ...
#the following example requires --bind yourtopofitclone:/topofit/
. /home/users/washbee1/local/freesurfer/SetUpFreeSurfer.sh
/topofit/preprocess /data/users2/washbee/hcp-plis-subj/358144
