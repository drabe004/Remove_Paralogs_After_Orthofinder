#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=FilterMajority
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Navigate to working directory
cd /path/to/your/project/Filter_Alignments_ByGeneID

# Load necessary modules
module load python
source ~/path/to/your/env/bin/activate

# Execute the Python script
python MajorityGeneIDs.py \
    /path/to/your/input_alignments/ \
    PercentageGeneIDs.txt \
    /path/to/your/output_directory/ \
    Logfile.txt
