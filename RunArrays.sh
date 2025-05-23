#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=1g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=IQtreeMaster
#SBATCH -p your_partition
#SBATCH --account=your_account

# Load required module
module load compatibility/agate-centos7

# Navigate to working directory
cd /path/to/your/project/IQTREE

# Submit IQTREE job arrays in batches, waiting for each to complete
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
