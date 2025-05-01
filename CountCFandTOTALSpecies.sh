#!/bin/bash -l        
#SBATCH --time=12:00:00
#SBATCH --ntasks=2
#SBATCH --mem=100g
#SBATCH --tmp=50g
#SBATCH --mail-type=ALL  
#SBATCH --mail-user=youremail 



cd your/path/to/dir

module load python3 

python CountCFandTOTALSpecies.py HighQualFilterMSAs1DCLEAN Cavefish_List.txt Species_List.txt HiQualCleanMSAs_COUNT.csv
