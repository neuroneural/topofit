#!/bin/bash
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=30g
#SBATCH -p qTRDGPU
#SBATCH --gres=gpu:RTX:1
#SBATCH -t 0-02:00
#SBATCH -J topofitr
#SBATCH -e jobs/error%A_%a.err
#SBATCH -o jobs/out%A_%a.out
#SBATCH -A psy53c17
#SBATCH --mail-type=ALL
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --oversubscribe


sleep 5s

module load singularity/3.10.2
singularity exec --nv --bind /data,/data/users2/washbee/speedrun/topofit:/topofit/, /data/users2/washbee/containers/speedrun/topofit_sr.sif /topofit/singularity/evaluaterh.sh &

wait

sleep 10s
