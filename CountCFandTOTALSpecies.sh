#!/bin/bash -l        
#SBATCH --time=12:00:00
#SBATCH --ntasks=2
#SBATCH --mem=100g
#SBATCH --tmp=50g
#SBATCH -p cavefish
#SBATCH --mail-type=ALL  
#SBATCH --mail-user=drabe004@umn.edu 



cd /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27

module load python3 

python CountCFandTOTALSpecies.py HighQualFilterMSAs1DCLEAN Cavefish_List.txt Species_List.txt HiQualCleanMSAs_COUNT.csv