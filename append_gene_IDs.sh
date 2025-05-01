#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=1g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=appendGeneID_array
#SBATCH -o blastp_%j_%a.out
#SBATCH -e blastp_%j_%a.err
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Navigate to working directory
cd /path/to/your/project/MakingAlignmentsWithGeneSymbolsFromBlast

# Load Python module
module load python

# Python script
PYTHON_SCRIPT_PATH="append_gene_IDs.py"

# Define directories
BLASTP_DIR="/path/to/blastp/results"
ALIGNMENT_DIR="/path/to/alignments_with_gene_symbols"

# Output directory
MODIFIED_ALIGNMENTS_DIR="${ALIGNMENT_DIR}/Alignments_withGeneIDs"
mkdir -p "$MODIFIED_ALIGNMENTS_DIR"

# File lists
BLASTP_LIST="/path/to/BlastPOutputList_small.txt"
ALIGNMENT_LIST="/path/to/ListofAlns_GS_small.txt"

# Extract current alignment file
ALIGNMENT_FILE="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${ALIGNMENT_LIST})"
ALIGNMENT_PREFIX=$(basename "$ALIGNMENT_FILE" | cut -d'_' -f1)
BLASTP_FILE=$(ls ${BLASTP_DIR} | grep "^${ALIGNMENT_PREFIX}_")

# Define output
OUTPUT_FILE_NAME=$(basename "$ALIGNMENT_FILE" .fa)_GeneIDs.fa
OUTPUT_FILE="${MODIFIED_ALIGNMENTS_DIR}/${OUTPUT_FILE_NAME}"

# Run script
python "$PYTHON_SCRIPT_PATH" "${BLASTP_DIR}/${BLASTP_FILE}" "${ALIGNMENT_DIR}/${ALIGNMENT_FILE}" "$OUTPUT_FILE"

echo "Processing complete for ${ALIGNMENT_FILE}."
