#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail 
#SBATCH --job-name=CountDupes




cd path/to/Count_Duplications_in_Alignments
module load python

source ~/envs/myenv/bin/activate

module load python 

ALNDIR=path/to/2MajorityGeneID_alignments

python CountDupsInAlns.py $ALNDIR Species_List.txt CountDupes.csv logfile.log
