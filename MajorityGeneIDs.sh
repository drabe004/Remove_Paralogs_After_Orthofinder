#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=drabe004@umn.edu
#SBATCH --job-name=FilerMajority
#SBATCH --partition=agsmall
#SBATCH --account=mcgaughs



cd /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Filter_Alignments_ByGeneID
module load python

source ~/envs/myenv/bin/activate

# Execute the Python script
python MajorityGeneIDs.py \
    /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/1AlignmentswithGeneSymbandGeneIDs/ \
    PercentageGeneIDs.txt \
    /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/1AlignmentswithGeneSymbandGeneIDs/2MajorityGeneID_alignments/ \
    Logfile.txt \