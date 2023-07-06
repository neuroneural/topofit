#!/bin/bash
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=30g
#SBATCH -p qTRDGPU
#SBATCH --gres=gpu:RTX:1
#SBATCH -t 0-02:00
#SBATCH -J topofitl
#SBATCH -e jobs/error%A.err
#SBATCH -o jobs/out%A.out
#SBATCH -A psy53c17
#SBATCH --mail-type=ALL
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --oversubscribe
#SBATCH --exclude=arctrdgn002,arctrddgxa001


sleep 5s

module load singularity/3.10.2
singularity exec --nv --bind /data,/data/users2/washbee/speedrun/topofit:/topofit/,/data/users2/washbee/speedrun/topofit-data:/topofit-data /data/users2/washbee/containers/speedrun/topofit_sandbox_bm2/ /topofit/singularity/benchmarks/bm.evaluatelh.sh &

wait

sleep 10s
