# Overview
The following three scripts are able to be run portably within a singularity container: 
train.sh, evaluate.sh, and preprocess.sh. 
Focus was placed on maintaining evaluate.sh, however preprocess can be run if a Freesurfer installation is available to source (version 6 and 7 probably work).


In order to run evaluate.sh or train.sh gpu support is needed. An srun session similar to the following will suffice:

    srun -p qTRDGPUH -A PSYC0002 -v -n1 -c 10 --mem=20G --gres=gpu:v100:1 --nodelist=trendsdgx003.rs.gsu.edu --pty /bin/bash

sometimes 003 node will be busy, you can replace 003 with 001,002,or 004. 
More cluster information can be found here:
https://trendscenter.github.io/wiki/docs/Cluster_queue_information.html#cluster-configuration

example srun commands can be found on the trends wiki
https://trendscenter.github.io/wiki/docs/SLURM_overview.html#example-commands
or you can find more information at slurm docs https://slurm.schedmd.com/srun.html

on a node that has singularity and the appropriate gpu support depending on the script (mentioned above), the following commands will run those scripts. 
First, you will need a copy of the appropriate topofit code/tag. Tag v1.0 was created in order to ensure that the code for this readme was stamped and available for
posterity. 

# Commands: 
    git clone -b v1.0 https://github.com/neuroneural/topofit.git

then 

## Download file requirement (from main topofit wiki)

The guided (or neighborhood-based) training loss requires a 500MB neighorhood mapping file that is too large to store on GitHub. In order to train a model, you must download [neighorhoods.npz](https://surfer.nmr.mgh.harvard.edu/ftp/data/topofit/neighborhoods.npz) and move it to the `topofit` subdirectory of this repository.

this can be done on a dev machine (dev machines have wget) with the following command:

        wget https://surfer.nmr.mgh.harvard.edu/ftp/data/topofit/neighborhoods.npz
then 

        mv neighborhoods.npz ./topofit/topofit/

## Run singularity commands 

    cd topofit 

then run the following commands for each script:

    singularity exec --nv --bind /data:/data/,/home:/home/,.:/topofit/ /data/users2/washbee/containers/topofitV1_release.sif /topofit/singularity_run/train.sh

or

    singularity exec --nv --bind /data:/data/,/home:/home/,.:/topofit/ /data/users2/washbee/containers/topofitV1_release.sif /topofit/singularity_run/evaluate.sh

or

    singularity exec --bind /data:/data/,/home:/home/,.:/topofit/ /data/users2/washbee/containers/topofitV1_release.sif /topofit/singularity_run/preprocess.sh

# About the commands 
## singularity, exec, bind 
exec runs the .sh scripts at the end of the command, which are located at the --bind directory (/topofit/) /topofit/singularity_run/...
when using the bind command, the format is "hostdirectory":"containerMountDirectory", so the above command assumes you are running these commands from within the cloned singularity codebase 
you may bind more directories, seperated by commas. 

## More on --bind:
https://docs.sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html

## --nv
The --nv command enables nvidia gpu support. The --nv command is not necessary for preprocessing. 
It's possible the /home directory doesnt' need to be mounted. One may potentially remove that from the above command. 

## Current location of the sif file
Until we have a singularity hub, the topofit sif file will be located at /data/users2/washbee/containers/topofitV1_release.sif

# Most importantly!
  each one of these shell scripts is examples of how to run the singularity container. Given the needs of whoever runs these containers will be quite unique, it is impossible
  to anticipate every possible usecase here. So, I have enabled the exceptional flexibility of using bash scripting with the exec command, but leave it to the end user to update each script to suit their needs. 
  ## Ideas for modification: 
  It is conceivable that you could move the singularity exec ... command into the .sh scripts so you don't need to type that.
  Or, you might want to add variables to each script so you can run more dynamically. 
  ## Minimum updates required!!!: 
   At minimum, you will need to change the paths inside the scripts to suit your data. 
  And, for the preprocess script it is likely advisable to enable variable support so you can use gnu parallel on a high performance cluster. 
  I will leave that for posterity to do. 
