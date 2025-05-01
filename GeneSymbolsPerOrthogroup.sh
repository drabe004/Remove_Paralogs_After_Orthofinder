#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=drabe004@umn.edu
#SBATCH --job-name=GS_plot
#SBATCH --partition=agsmall
#SBATCH --account=mcgaughs



cd /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/QuantifyGeneSymbolsInMSAs

module load python

source ~/envs/myenv/bin/activate

python GeneSymbolsPerOrthogroup.py  12kGeneSymbolMatrix.csv GeneSymbolsPerOrthogroup.csv
