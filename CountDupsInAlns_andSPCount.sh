#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=CountDupes_andSpecs
#SBATCH --partition=your_partition
#SBATCH --account=your_account_name

# Navigate to the working directory
cd /path/to/working/directory/Count_Duplications_in_Alignments

# Load the necessary module (adjust as needed)
module load python

# Activate your Python virtual environment (update with actual path or remove if not used)
source ~/path/to/your/env/bin/activate

# Define variables for input and output
ALNDIR=/path/to/filtered_alignments_directory
SPECIES_LIST=Species_List.txt
CAVEFISH_LIST=Cavefish_List.txt
OUTPUT_FILE=CountDupesANDspecies.csv
LOG_FILE=logfile.log

# Run the Python script
python CountDupsInAlns_andSPCount.py "$ALNDIR" "$SPECIES_LIST" "$CAVEFISH_LIST" "$OUTPUT_FILE" "$LOG_FILE"
