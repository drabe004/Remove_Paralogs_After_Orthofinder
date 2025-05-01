#!/bin/bash
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=drabe004@umn.edu
#SBATCH --job-name=realign_mafft
#SBATCH -o realign_%j_%a.out
#SBATCH -e realign_%j_%a.err
#SBATCH --partition=agsmall
#SBATCH --account=mcgaughs

# Load MAFFT module
module load mafft

# Full path to the MAFFT executable
mafft_path="/common/software/install/migrated/mafft/7.475/bin/mafft"

# Directory containing the alignment files
ALIGNMENT_DIR="/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/2MajorityGeneID_alignments/LeftOvers"

# Path to the list of alignment files
ALIST="/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/2MajorityGeneID_alignments/LeftOvers/list.txt"
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
done
