#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=1g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=drabe004@umn.edu
#SBATCH --job-name=IQtreeMaster
#SBATCH -p astyanax
#SBATCH --account=mcgaughs

module load compatibility/agate-centos7


cd /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/IQTREE


sbatch --array=1-1000 --wait IQTREE_Arrays.sh
sbatch --array=1001-2000 --wait IQTREE_Arrays.sh
sbatch --array=2001-3000 --wait IQTREE_Arrays.sh
sbatch --array=3001-4000 --wait IQTREE_Arrays.sh
sbatch --array=4001-5000 --wait IQTREE_Arrays.sh
sbatch --array=5001-6000 --wait IQTREE_Arrays.sh
sbatch --array=6001-7000 --wait IQTREE_Arrays.sh
sbatch --array=7001-8000 --wait IQTREE_Arrays.sh
sbatch --array=8001-9000 --wait IQTREE_Arrays.sh
sbatch --array=9001-10000 --wait IQTREE_Arrays.sh
sbatch --array=10001-11000 --wait IQTREE_Arrays.sh
sbatch --array=11001-12000 --wait IQTREE_Arrays.sh
sbatch --array=12001-12171 --wait IQTREE_Arrays.sh
