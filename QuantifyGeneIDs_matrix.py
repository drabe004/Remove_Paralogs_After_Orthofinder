import os
from Bio import AlignIO
import pandas as pd
import argparse

def count_gene_ids_in_msa(directory):
    # Dictionary to hold the counts of each gene ID in each orthogroup
    orthogroup_gene_counts = {}

    # Loop over each file in the directory
    for filename in os.listdir(directory):
        if filename.endswith('.fa'):  # Adjust as necessary for the file extension
            orthogroup = filename.split('_')[0]  # Extract orthogroup from filename
            path = os.path.join(directory, filename)
            print(f"Processing file: {filename}")  # Debugging output
            try:
                alignment = AlignIO.read(path, "fasta")  # Ensure the format is 'fasta'
                # Initialize a dictionary to count occurrences of each gene ID in this orthogroup
                if orthogroup not in orthogroup_gene_counts:
                    orthogroup_gene_counts[orthogroup] = {}

                # Process each record in the alignment
                for record in alignment:
                    parts = record.description.split('__')
                    if len(parts) > 1:
                        gene_id = parts[-1].strip()  # Strip to remove any trailing whitespace
                        if gene_id in orthogroup_gene_counts[orthogroup]:
                            orthogroup_gene_counts[orthogroup][gene_id] += 1
                        else:
                            orthogroup_gene_counts[orthogroup][gene_id] = 1
            except Exception as e:
                print(f"Failed to read or process {filename}: {e}")  # Error handling

    # Create a DataFrame from the dictionary
    df = pd.DataFrame(orthogroup_gene_counts).fillna(0).astype(int)
    print(f"DataFrame created. Shape: {df.shape}")  # Debugging output
    return df

def main():
    parser = argparse.ArgumentParser(description='Count gene IDs in MSA files.')
    parser.add_argument('directory', type=str, help='Directory containing MSA files')
    parser.add_argument('output_file', type=str, help='Output CSV file name')

    args = parser.parse_args()

    # Get the count matrix
    matrix = count_gene_ids_in_msa(args.directory)

    # Optionally, save the matrix to a CSV file
    matrix.to_csv(args.output_file)
    print(f"Output saved to {args.output_file}")

if __name__ == '__main__':
    main()
