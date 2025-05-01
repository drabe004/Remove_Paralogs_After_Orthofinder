#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=1g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=drabe004@umn.edu
#SBATCH --job-name=appendGeneID_array
#SBATCH -o blastp_%j_%a.out
#SBATCH -e blastp_%j_%a.err
#SBATCH --partition=agsmall
#SBATCH --account=mcgaughs

cd /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/MakingAlignmentsWithGeneSymbolsFromBlast

# Activate the environment with Python and necessary packages
module load python

# Assuming the Python script is named "append_gene_IDs.py"
PYTHON_SCRIPT_PATH="append_gene_IDs.py"

# Directories for BLASTP outputs and alignment files
BLASTP_DIR="/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x_unaligned/BlastP_Results/"
ALIGNMENT_DIR="/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/Alignments_withGeneSymbols"

# Output directory for modified alignment files
MODIFIED_ALIGNMENTS_DIR="${ALIGNMENT_DIR}/Alignments_withGeneIDs"
mkdir -p "$MODIFIED_ALIGNMENTS_DIR"

# Lists of BLASTP and alignment files (one file per line)
BLASTP_LIST="/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/BlastPOutputList_small.txt"
ALIGNMENT_LIST="/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/Alignments_withGeneSymbols/ListofAlns_GS_small.txt"

# Extract the file name for the current array job
ALIGNMENT_FILE="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${ALIGNMENT_LIST})"

# Extract prefix up to the first underscore
ALIGNMENT_PREFIX=$(basename "$ALIGNMENT_FILE" | cut -d'_' -f1)

# Find the BLASTP file that matches the extracted prefix
BLASTP_FILE=$(ls ${BLASTP_DIR} | grep "^${ALIGNMENT_PREFIX}_")

# Define output file name based on the alignment file
OUTPUT_FILE_NAME=$(basename "$ALIGNMENT_FILE" .fa)_GeneIDs.fa
OUTPUT_FILE="${MODIFIED_ALIGNMENTS_DIR}/${OUTPUT_FILE_NAME}"

# Run the Python script with the current set of files
python "$PYTHON_SCRIPT_PATH" "${BLASTP_DIR}/${BLASTP_FILE}" "${ALIGNMENT_DIR}/${ALIGNMENT_FILE}" "$OUTPUT_FILE"

echo "Processing complete for ${ALIGNMENT_FILE}."
