#!/bin/bash
#SBATCH --account=def-mcrowley
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G      # memory; default unit is megabytes
#SBATCH --gpus-per-node=1
#SBATCH --time=24:0:0           # time (DD-HH:MM)
#SBATCH --output=useful-logs/slurm-%j-gends10x.out


cd /home/h86chen/scratch/STEVE-1 && source .venv/bin/activate
cd /home/h86chen/scratch/STEVE-1-Memory
module load scipy-stack StdEnv/2020 gcc/9.3.0 cuda/11.4 opencv java/1.8.0_192 python/3.9 

# This will download the dataset from OpenAI to a local directory and convert it to the format used by the code.

OUTPUT_DIR_CONTRACTOR=data/dataset_contractor/
N_EPISODES_CONTRACTOR=5000

# python steve1/data/generation/convert_from_contractor.py \
# --batch_size 256 \
# --num_episodes $N_EPISODES_CONTRACTOR \
# --worker_id 1 \
# --output_dir $OUTPUT_DIR_CONTRACTOR \
# --index 8.x

# python steve1/data/generation/convert_from_contractor.py \
# --batch_size 64 \
# --num_episodes $N_EPISODES_CONTRACTOR \
# --worker_id 0 \
# --output_dir $OUTPUT_DIR_CONTRACTOR \
# --index 9.x

python steve1/data/generation/convert_from_contractor.py \
--batch_size 64 \
--num_episodes $N_EPISODES_CONTRACTOR \
--worker_id 0 \
--output_dir $OUTPUT_DIR_CONTRACTOR \
--index 10.x

# # This will generate mixed agent episodes in the format used by the code.

# OUTPUT_DIR_MIXED_AGENTS=data/dataset_mixed_agents/
# N_EPISODES_MIXED_AGENTS=5

# python steve1/data/generation/gen_mixed_agents.py \
# --output_dir $OUTPUT_DIR_MIXED_AGENTS \
# --max_timesteps 7200 \
# --min_timesteps 1000 \
# --switch_agent_prob 0.001 \
# --perform_spin_prob 0.00133 \
# --batch_size 4 \
# --num_episodes $N_EPISODES_MIXED_AGENTS \


