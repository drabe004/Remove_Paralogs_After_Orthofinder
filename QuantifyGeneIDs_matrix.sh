#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=GID_matrix
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Navigate to the working directory
cd /path/to/your/project/QuantifyGeneSymbolsInMSAs

# Load Python module
module load python

# Activate virtual environment
source ~/path/to/your/env/bin/activate

# Run the script to generate the GeneID matrix
python QuantifyGeneIDs_matrix.py /path/to/input_alignment_dir 12kGeneIDMatrix.csv
