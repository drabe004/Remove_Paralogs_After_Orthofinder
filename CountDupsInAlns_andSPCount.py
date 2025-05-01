import os
import pandas as pd
from Bio import AlignIO
import argparse

def count_duplications(input_directory, species_list_file, cavefish_list_file, output_file, log_file):
    # Read species list
    with open(species_list_file, 'r') as f:
        species_list = [line.strip() for line in f.readlines()]
    
    # Read cavefish species list
    with open(cavefish_list_file, 'r') as f:
        cavefish_list = [line.strip() for line in f.readlines()]
    
    # Open the log file
    with open(log_file, 'w') as log:
        results = []

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
                
                # Set to track unique species
                unique_species = set()
                unique_cavefish_species = set()
                
                for record in alignment:
                    for species in species_list:
                        if species in record.description:
                            species_counts[species] += 1
                            unique_species.add(species)
                            if species in cavefish_list:
                                unique_cavefish_species.add(species)
                
                # Calculate duplications
                duplication_count = sum(count - 1 for count in species_counts.values() if count > 1)
                num_unique_species = len(unique_species)
                num_unique_cavefish_species = len(unique_cavefish_species)
                
                results.append((orthogroup, duplication_count, num_unique_species, num_unique_cavefish_species))
                log.write(f"Processed {orthogroup}: {duplication_count} duplications, {num_unique_species} unique species, {num_unique_cavefish_species} unique cavefish species\n")
        
        # Write results to CSV
        df = pd.DataFrame(results, columns=['Orthogroup', 'Duplications', 'UniqueSpecies', 'UniqueCavefishSpecies'])
        df.to_csv(output_file, index=False)
        log.write(f"Results written to {output_file}\n")

def main():
    parser = argparse.ArgumentParser(description='Count duplications in alignment files and tally unique species.')
    parser.add_argument('input_directory', type=str, help='Directory containing the alignment files')
    parser.add_argument('species_list_file', type=str, help='Text file containing the list of species')
    parser.add_argument('cavefish_list_file', type=str, help='Text file containing the list of cavefish species')
    parser.add_argument('output_file', type=str, help='Output CSV file for the results')
    parser.add_argument('log_file', type=str, help='File to save the log output')

    args = parser.parse_args()

    # Count the duplications and tally unique species
    count_duplications(args.input_directory, args.species_list_file, args.cavefish_list_file, args.output_file, args.log_file)

if __name__ == '__main__':
    main()
