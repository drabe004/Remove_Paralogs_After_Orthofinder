import argparse

def parse_blastp_output(filepath):
    mapping = {}
    with open(filepath) as f:
        for line in f:
            parts = line.strip().split('\t')
            # Extracting the detailed gene information, assuming it's in a specific column
            detailed_info = parts[-1]  # Update this index if the gene symbol info is in a different column
            gene_symbol_marker = "gene_symbol:"
            if gene_symbol_marker in detailed_info:
                # Extracting the gene symbol following 'gene_symbol:'
                gene_symbol_start = detailed_info.find(gene_symbol_marker) + len(gene_symbol_marker)
                gene_symbol = detailed_info[gene_symbol_start:].split()[0]  # Adjust if the format requires
            else:
                gene_symbol = "NONEFOUND"
            mapping[parts[0]] = gene_symbol.strip()  # Ensure there are no leading/trailing spaces
    return mapping

def modify_alignment_file(blastp_mapping, msa_filepath, output_filepath):
    with open(msa_filepath) as msa_file, open(output_filepath, 'w') as output_file:
        for line in msa_file:
            if line.startswith('>'):
                query_id = line[1:].strip()  # Remove '>' and newline
                gene_symbol = blastp_mapping.get(query_id, 'NONEFOUND')
                # Create the modified header with the gene symbol
                modified_header = f">{query_id}__{gene_symbol}\n"
                output_file.write(modified_header)
            else:
                output_file.write(line)

def main():
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Append gene symbols to sequence headers in a fasta file.")
    parser.add_argument("blastp_file", help="Path to the BLASTP output file.")
    parser.add_argument("msa_file", help="Path to the MSA file.")
    parser.add_argument("output_file", help="Path for the output file.")

    # Parse arguments
    args = parser.parse_args()

    # Parse the BLASTP output to get the mapping
    blastp_mapping = parse_blastp_output(args.blastp_file)

    # Modify the MSA file based on the BLASTP mapping and write the output
    modify_alignment_file(blastp_mapping, args.msa_file, args.output_file)

if __name__ == "__main__":
    main()
