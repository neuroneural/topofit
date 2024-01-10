#!/bin/bash
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=1g
#SBATCH -p qTRDGPU
#SBATCH -t 5-00:00
#SBATCH -J topofprep
#SBATCH -e jobs/error%A.err
#SBATCH -o jobs/out%A.out
#SBATCH -A psy53c17
#SBATCH --mail-type=ALL
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --oversubscribe
#SBATCH --exclude=arctrdgn002,arctrddgx001

sleep 5s
module load singularity/3.10.2

singularity exec --bind /data,/data/users2/washbee/speedrun/topofit:/topofit /data/users2/washbee/containers/speedrun/topofit_sr.sif /topofit/singularity/preprocess.sh $SLURM_ARRAY_TASK_ID


