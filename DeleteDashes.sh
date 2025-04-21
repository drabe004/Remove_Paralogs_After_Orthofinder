#!/bin/bash -l        
#SBATCH --time=96:00:00
#SBATCH --ntasks=1
#SBATCH --mem=50g
#SBATCH --tmp=50g
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=youremail

# Navigate to the directory containing the .fa files
cd /alignment/Dir

# Define the directory containing the .fa files
alignment_dir="/alignment/dir"

# Loop through each .fa file in the directory and remove hyphens from sequence lines
for file in "$alignment_dir"/*.fa; do
    sed -i.bak '/^>/! s/-//g' "$file"
done
