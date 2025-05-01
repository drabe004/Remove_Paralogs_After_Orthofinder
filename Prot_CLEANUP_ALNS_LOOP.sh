#!/bin/bash -l        
#SBATCH --time=30:00:00
#SBATCH --ntasks=10
#SBATCH --mem=100g
#SBATCH --tmp=10g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=prot_cleanup

# Load Python
module load python3

# Navigate to your working directory
cd /path/to/your/project_directory

# Run protein alignment cleanup
# Usage: script.py <input_dir> <output_dir> <start_threshold> <gap_threshold> <gap_cutoff> <log_file>
python Prot_CLEANUP_ALNS_LOOP.py InputDirectory OutputDirectory .9 .5 .75 debug_log.txt
