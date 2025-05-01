#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=1g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=appendGeneSymbol_array
#SBATCH -o blastp_%j_%a.out
#SBATCH -e blastp_%j_%a.err
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Navigate to working directory
cd /path/to/your/project/MakingAlignmentsWithGeneSymbolsFromBlast

# Load Python module
module load python

# Path to Python script
PYTHON_SCRIPT_PATH="append_gene_symbols.py"

# Directories for BLASTP outputs and alignment files
BLASTP_DIR="/path/to/BlastP_Results"
ALIGNMENT_DIR="/path/to/Alignments"

# Output directory for modified alignment files
MODIFIED_ALIGNMENTS_DIR="${ALIGNMENT_DIR}/Alignments_withGeneSymbols"
mkdir -p "$MODIFIED_ALIGNMENTS_DIR"

# Lists of BLASTP and alignment files (one file per line)
BLASTP_LIST="/path/to/BlastPOutputList.txt"
ALIGNMENT_LIST="/path/to/ListOfMSAs.txt"

# Extract the file name for the current array job
BLASTP_FILE="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${BLASTP_LIST})"
ALIGNMENT_FILE="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${ALIGNMENT_LIST})"

# Define output file name based on the alignment file
OUTPUT_FILE_NAME=$(basename "$ALIGNMENT_FILE" .fa)_GeneSymbols.fa
OUTPUT_FILE="${MODIFIED_ALIGNMENTS_DIR}/${OUTPUT_FILE_NAME}"

# Run the Python script with the current set of files
python "$PYTHON_SCRIPT_PATH" "${BLASTP_DIR}/${BLASTP_FILE}" "${ALIGNMENT_DIR}/${ALIGNMENT_FILE}" "$OUTPUT_FILE"

echo "Processing complete for ${ALIGNMENT_FILE}."
