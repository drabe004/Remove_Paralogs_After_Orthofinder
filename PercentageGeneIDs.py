import os
from Bio import AlignIO
import pandas as pd
import argparse

def calculate_gene_id_percentages(directory, output_file):
    # Initialize a list to hold the output data
    output_data = []

    # Loop over each file in the directory
    for filename in os.listdir(directory):
        if filename.endswith('.fa'):  # Adjust as necessary for the file extension
            orthogroup = filename.split('_')[0]  # Extract orthogroup from filename
            path = os.path.join(directory, filename)
            print(f"Processing file: {filename}")  # Debugging output
            try:
                alignment = AlignIO.read(path, "fasta")  # Ensure the format is 'fasta'
                total_sequences = len(alignment)
                gene_id_counts = {}

                # Process each record in the alignment
                for record in alignment:
                    parts = record.description.split('__')
                    if len(parts) > 1:
                        gene_id = parts[-1].strip()  # Strip to remove any trailing whitespace
                        if gene_id in gene_id_counts:
                            gene_id_counts[gene_id] += 1
                        else:
                            gene_id_counts[gene_id] = 1

                # Calculate percentages
                percentages = {gene_id: (count / total_sequences) * 100 for gene_id, count in gene_id_counts.items()}
                percentages["NONEFOUND"] = 100 - sum(percentages.values()) if total_sequences > 0 else 0

                # Sort percentages by value in descending order
                sorted_percentages = sorted(percentages.items(), key=lambda x: x[1], reverse=True)

                # Prepare the output line
                output_line = [orthogroup]
                for gene_id, percent in sorted_percentages:
                    output_line.append(f"{gene_id} {percent:.2f}%")

                # Append to the output data
                output_data.append(" ".join(output_line))

            except Exception as e:
                print(f"Failed to read or process {filename}: {e}")  # Error handling

    # Write the output data to a CSV file
    with open(output_file, 'w') as f:
        for line in output_data:
            f.write(line + '\n')

    print(f"Output saved to {output_file}")

def main():
    parser = argparse.ArgumentParser(description='Calculate gene ID percentages in MSA files.')
    parser.add_argument('directory', type=str, help='Directory containing MSA files')
    parser.add_argument('output_file', type=str, help='Output CSV file name')

    args = parser.parse_args()

    # Generate the percentages and save to file
    calculate_gene_id_percentages(args.directory, args.output_file)

if __name__ == '__main__':
    main()
