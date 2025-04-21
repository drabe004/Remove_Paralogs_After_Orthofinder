#!/bin/bash -l        
#SBATCH --time=30:00:00
#SBATCH --ntasks=10
#SBATCH --mem=100g
#SBATCH --tmp=10g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail



module load python3


cd /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27


#CallPython #Scripts  #InputDirectoryWithProteinAlignments #OutputDirectory #ThresholdPercentagePresenceToFirstAminoAcid #SecondaryThresholdifNoAminoAcidMeetsTheFistThreshold #GapPercentageToCutSequences(inverse)

python Prot_CLEANUP_ALNS_LOOP.py InputDirectory OutputDirectory .9 .5 .75 debug_log.txt




