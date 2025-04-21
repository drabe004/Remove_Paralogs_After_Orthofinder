import os
import sys
from Bio import SeqIO
import csv

def read_species_list(file_path):
    """Reads the species list from a file and returns it as a list."""
    with open(file_path, 'r') as file:
        return [line.strip() for line in file]

def count_species_in_fasta(fasta_file, cavefish_list, total_species_list):
    """Counts how many different species from the cavefish and total species lists are found in the FASTA file."""
    cavefish_found = set()
    total_species_found = set()
    for record in SeqIO.parse(fasta_file, "fasta"):
        header = record.description
        for species in total_species_list:
            if species in header:
                total_species_found.add(species)
                break  # Stop once the first match is found
        for species in cavefish_list:
            if species in header:
                cavefish_found.add(species)
                break  # Stop once the first match is found
    return len(cavefish_found), len(total_species_found)

def main(directory, cavefish_list_file, total_species_list_file, output_csv):
    cavefish_list = read_species_list(cavefish_list_file)
    total_species_list = read_species_list(total_species_list_file)
    with open(output_csv, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['File Name', 'Cavefish Species', 'Total Species'])

        for filename in os.listdir(directory):
            if filename.endswith(".fa"):
                file_path = os.path.join(directory, filename)
                cavefish_count, total_count = count_species_in_fasta(file_path, cavefish_list, total_species_list)
                writer.writerow([filename, cavefish_count, total_count])
                print(f'Processed {filename} with {cavefish_count} Cavefish species and {total_count} total species.')

if __name__ == "__main__":
    if len(sys.argv) < 5:
        print("Usage: python script.py <directory_path> <cavefish_list_file> <total_species_list_file> <output_csv_path>")
        sys.exit(1)

    directory_path = sys.argv[1]
    cavefish_list_file = sys.argv[2]
    total_species_list_file = sys.argv[3]
    output_csv_path = sys.argv[4]
    main(directory_path, cavefish_list_file, total_species_list_file, output_csv_path)
