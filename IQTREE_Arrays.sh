#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=IQTREEArrays
#SBATCH -o iqtree_%j_%a.out
#SBATCH -e iqtree_%j_%a.err
#SBATCH -p your_partition
#SBATCH --account=your_account
#SBATCH --array=2501-3500  # Adjust this to match number of lines in the list

# Set working directory
cd /path/to/your/project/IQTREE

# Load the module (make sure iqtree is available!)
module purge
module load iqtree2/2.1.2-gcc-13.1.0-xsnl63s

# Input & Output
alignment_dir="/path/to/your/project/Protein_Alignments"
ALIST="${alignment_dir}/list.txt"  # File containing list of alignment file names

# Output path
outdir="IQTREE_April14_2025"
mkdir -p "$outdir"

# Get file name from list
file=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$ALIST")
basename=$(basename "$file" .fa)

# Run IQ-TREE into output directory
iqtree2 -s "${alignment_dir}/${file}" -nt AUTO -m MFP -bb 1000 -alrt 1000 -pre "${outdir}/IQTREE_${basename}"
