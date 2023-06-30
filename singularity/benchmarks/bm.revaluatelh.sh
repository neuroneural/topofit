#!/bin/bash -p
. /opt/miniconda3/bin/activate topofit
#enter the command you would like to run below or modify this script to be more dynamic
#eg. /topofit/evaluate ...
#eg. /topofit/train ... 
#eg. /topofit/preprocess ...
#the following example requires --bind yourtopofitclone:/topofit/
filename='/topofit/singularity/benchmarks/test_ids.csv'
output=()

while read -r line; do 
	output+=(/topofit-data/${line})
done < $filename

random_index=$(( RANDOM % ${#output[@]} ))
random_element="${output[$random_index]}"

echo 'array is read'
/topofit/bm.evaluate --subjs ${random_element} --hemi lh --model /data/users2/washbee/speedrun/topofit/bmoutput/lh.2125.pt

