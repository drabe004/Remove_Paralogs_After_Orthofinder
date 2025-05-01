#!/bin/bash
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=realign_mafft
#SBATCH -o realign_%j_%a.out
#SBATCH -e realign_%j_%a.err
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Load MAFFT module
module load mafft

# Full path to the MAFFT executable
mafft_path="/path/to/mafft/bin/mafft"

# Directory containing the alignment files
ALIGNMENT_DIR="/path/to/your/project/Alignments"

# Path to the list of alignment files
ALIST="${ALIGNMENT_DIR}/list.txt"
ALIGNMENT_FILE="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${ALIST})"

# Base output directory for realigned files
BASE_OUTPUT_DIR="${ALIGNMENT_DIR}/ReAligned_MAFFT"

# Create the unique output directory if it does not exist
mkdir -p "$BASE_OUTPUT_DIR"

# Full path to the input alignment file
input_file="${ALIGNMENT_DIR}/${ALIGNMENT_FILE}"

# Extract the base name of the input file
base_name=$(basename "$ALIGNMENT_FILE" .fasta)

# Define the output file
output_file="${BASE_OUTPUT_DIR}/${base_name}_realigned.fa"

# Run MAFFT
$mafft_path --auto "$input_file" > "$output_file"

echo "Realignment complete for ${input_file}."
