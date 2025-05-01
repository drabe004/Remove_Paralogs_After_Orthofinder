#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=GS_plot
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Navigate to the working directory
cd /path/to/your/project/QuantifyGeneSymbolsInMSAs

# Load necessary modules
module load python

# Activate Python environment
source ~/path/to/your/env/bin/activate

# Run the analysis script
python GeneSymbolsPerOrthogroup.py 12kGeneSymbolMatrix.csv GeneSymbolsPerOrthogroup.csv
