#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail
#SBATCH --job-name=BlastArrays
#SBATCH -o blastp_%j_%a.out
#SBATCH -e blastp_%j_%a.err



module load ncbi_blast+/2.13.0

# Updated database path
database="Proteomes/Danio_rerio.GRCz11.pep.all.fa"

alignment_dir="/Results/MultipleSequenceAlignments_Unaligned/"

# Output directory for BLAST results
output_dir="${alignment_dir}/BlastP_Results"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# List of Alignment Files
ALIST="Results_Jun27/ListOfFilestoBlast.txt"
ALIGNMENT_FILE="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${ALIST})"

output_file_name=$(basename "$ALIGNMENT_FILE" .fa).blastp
output_file="${output_dir}/${output_file_name}"


# Run BLAST with updated output format
blastp -query "$alignment_dir/$ALIGNMENT_FILE" \
-db "$database" \
-num_threads ${SLURM_CPUS_PER_TASK} \
-evalue 1e-6 \
-max_hsps 1 \
-max_target_seqs 1 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send
evalue bitscore stitle" \
-out "$output_file"

echo "BLAST processing complete."

