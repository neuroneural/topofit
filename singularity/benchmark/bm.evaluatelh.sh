#!/bin/bash -p
. /opt/miniconda3/bin/activate topofit
#enter the command you would like to run below or modify this script to be more dynamic
#eg. /topofit/evaluate ...
#eg. /topofit/train ... 
#eg. /topofit/preprocess ...
#the following example requires --bind yourtopofitclone:/topofit/
readarray -t a < /topofit/singularity/benchmarks/test_ids.csv
echo 'array is read'
/topofit/bm.evaluate --subjs /data/users2/washbee/speedrun/topofit-data/${a[${SLURM_ARRAY_TASK_ID}]} --hemi lh --model /data/users2/washbee/speedrun/topofit/bmoutput/lh.2125.pt
