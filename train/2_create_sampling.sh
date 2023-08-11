#!/bin/bash
#SBATCH --account=def-mcrowley
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G      # memory; default unit is megabytes
#SBATCH --time=4:0:0           # time (DD-HH:MM)
#SBATCH --output=useful-logs/slurm-%j-createsampling.out

cd /home/h86chen/scratch/STEVE-1 && source .venv/bin/activate
cd /home/h86chen/scratch/STEVE-1-Memory
module load scipy-stack StdEnv/2020 gcc/9.3.0 cuda/11.4 opencv java/1.8.0_192 python/3.9 

python steve1/data/sampling/generate_sampling.py \
--type neurips \
--name neurips \
--output_dir data/samplings \
--val_frames 100_000 \
--train_frames -1