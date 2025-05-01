import os
import pandas as pd
from Bio import AlignIO
import argparse

def count_duplications(input_directory, species_list_file, output_file, log_file):
    # Read species list
    with open(species_list_file, 'r') as f:
        species_list = [line.strip() for line in f.readlines()]
    
    # Open the log file
    with open(log_file, 'w') as log:
        duplications = []

        # Iterate over each alignment file in the input directory
        for filename in os.listdir(input_directory):
            if filename.endswith('.fa'):
                orthogroup = filename.split('_')[0]  # Extract orthogroup from filename
                path = os.path.join(input_directory, filename)
                try:
                    alignment = AlignIO.read(path, "fasta")
                except Exception as e:
                    log.write(f"Failed to read {path}: {e}\n")
                    continue
                
                # Dictionary to count sequences for each species
                species_counts = {species: 0 for species in species_list}
                
                for record in alignment:
                    for species in species_list:
                        if species in record.description:
                            species_counts[species] += 1
                
                # Calculate duplications
                duplication_count = sum(count - 1 for count in species_counts.values() if count > 1)
                duplications.append((orthogroup, duplication_count))
                log.write(f"Processed {orthogroup}: {duplication_count} duplications\n")
        
        # Write results to CSV
        df = pd.DataFrame(duplications, columns=['Orthogroup', 'Duplications'])
        df.to_csv(output_file, index=False)
        log.write(f"Results written to {output_file}\n")

def main():
    parser = argparse.ArgumentParser(description='Count duplications in alignment files.')
    parser.add_argument('input_directory', type=str, help='Directory containing the alignment files')
    parser.add_argument('species_list_file', type=str, help='Text file containing the list of species')
    parser.add_argument('output_file', type=str, help='Output CSV file for the results')
    parser.add_argument('log_file', type=str, help='File to save the log output')

    args = parser.parse_args()

    # Count the duplications
    count_duplications(args.input_directory, args.species_list_file, args.output_file, args.log_file)

if __name__ == '__main__':
    main()
