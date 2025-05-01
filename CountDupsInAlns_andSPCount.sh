#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=drabe004@umn.edu
#SBATCH --job-name=CountDupes_andSpecs
#SBATCH --partition=agsmall
#SBATCH --account=mcgaughs


cd /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Count_Duplications_in_Alignments

# Load the necessary Python module
module load python

# Activate the Python virtual environment
source ~/envs/myenv/bin/activate

# Define variables for input and output directories/files
ALNDIR=/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/2MajorityGeneID_alignments
SPECIES_LIST=Species_List.txt
CAVEFISH_LIST=Cavefish_List.txt
OUTPUT_FILE=CountDupesANDspecies.csv
LOG_FILE=logfile.log

# Run the Python script with the specified arguments
python CountDupsInAlns_andSPCount.py $ALNDIR $SPECIES_LIST $CAVEFISH_LIST $OUTPUT_FILE $LOG_FILE
