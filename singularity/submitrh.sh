#!/bin/bash
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=40g
#SBATCH -p qTRDGPUH
#SBATCH --gres=gpu:V100:1
#SBATCH -t 5-00:00
#SBATCH -J topofitr
#SBATCH -e jobs/error%A.err
#SBATCH -o jobs/out%A.out
#SBATCH -A psy53c17
#SBATCH --mail-type=ALL
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --oversubscribe


sleep 5s

module load singularity/3.10.2
singularity exec --nv --bind /data:/data/,/data/users2/washbee/speedrun/topofit:/topofit/,/data/users2/washbee/speedrun/topofit-data:/subj /data/users2/washbee/containers/speedrun/topofit_sr.sif /topofit/singularity/train.sh rh &

wait

sleep 10s
