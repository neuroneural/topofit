#!/bin/bash -p
. /opt/miniconda3/bin/activate topofit
#enter the command you would like to run below or modify this script to be more dynamic
#eg. /topofit/evaluate ...
#eg. /topofit/train ... 
#eg. /topofit/preprocess ...
#the following example requires --bind yourtopofitclone:/topofit/
filename='/topofit/singularity/benchmarks/bm.csv'
output=""

while read -r line; do 
    if [ -z "$output" ]; then
        output="/topofit-data/${line}"
    else
        output="$output /topofit-data/${line}"
    fi
done < $filename

echo $output

readarray -t a < /topofit/singularity/benchmarks/test_ids.csv
echo 'array is read'
/topofit/bm.evaluate --subjs ${output} --hemi lh --model /data/users2/washbee/speedrun/topofit/bmoutput/lh.2125.pt

