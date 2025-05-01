#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=percentGIDs
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Navigate to the working directory
cd /path/to/your/project/QuantifyGeneSymbolsInMSAs

# Load required modules and activate environment
module load python
source ~/path/to/your/env/bin/activate

# Run the script to calculate gene ID percentages
python PercentageGeneIDs.py /path/to/your/input_alignments PercentageGeneIDs.csv
