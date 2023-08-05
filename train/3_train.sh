#!/bin/bash
#SBATCH --account=def-mcrowley
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G      # memory; default unit is megabytes
#SBATCH --gpus=1
#SBATCH --time=24:0:0           # time (DD-HH:MM)

source /home/h86chen/scratch/STEVE-1/.venv/bin/activate
cd /home/h86chen/scratch/STEVE-1-Memory
module load scipy-stack StdEnv/2020 gcc/9.3.0 cuda/11.4 opencv java/1.8.0_192 python/3.9 

# This will resume training if data/training_checkpoint is not empty. If you want to start from scratch, delete the directory.

xvfb-run accelerate launch --num_processes 1 --mixed_precision bf16 steve1/training/train.py \
--in_model data/weights/vpt/2x.model \
--in_weights data/weights/vpt/rl-from-foundation-2x.weights \
--out_weights data/weights/steve1-memory-16m/steve1-memory-16m.weights \
--trunc_t 16 \
--T 640 \
--batch_size 4 \
--gradient_accumulation_steps 4 \
--num_workers 4 \
--weight_decay 0.039428 \
--n_frames 16_000_000 \
--learning_rate 4e-5 \
--warmup_frames 1_000_000 \
--p_uncond 0.1 \
--min_btwn_goals 15 \
--max_btwn_goals 200 \
--checkpoint_dir data/training_checkpoint \
--val_freq 1000 \
--val_freq_begin 100 \
--val_freq_switch_steps 500 \
--val_every_nth 10 \
--save_each_val False \
--sampling neurips \
--sampling_dir data/samplings/ \
--snapshot_every_n_frames 50_000_000 \
--val_every_nth 1