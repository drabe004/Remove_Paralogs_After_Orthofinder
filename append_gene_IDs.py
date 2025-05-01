import argparse

def parse_blastp_output(filepath):
    mapping = {}
    with open(filepath) as f:
        for line in f:
            parts = line.strip().split('\t')
            detailed_info = parts[-1]  # Extract the last column with detailed information
            gene_marker = "gene:"
            
            gene = "NONEFOUND"
            for part in detailed_info.split():
                if part.startswith(gene_marker):
                    gene = part[len(gene_marker):].strip()
                    break
            
            query_id = parts[0].strip()
            mapping[query_id] = gene
            print(f"Mapping: {query_id} -> {gene}")  # Debug print
            
    return mapping

def modify_alignment_file(blastp_mapping, msa_filepath, output_filepath):
    with open(msa_filepath) as msa_file, open(output_filepath, 'w') as output_file:
        for line in msa_file:
            if line.startswith('>'):
                query_id_with_suffix = line[1:].strip()
                # Strip the '__' and everything after
                query_id = query_id_with_suffix.split('__')[0]
                gene = blastp_mapping.get(query_id, 'NONEFOUND')
                print(f"Matching Alignment ID: {query_id_with_suffix} -> {gene}")  # Debug print
                modified_header = f">{query_id_with_suffix}__{gene}\n"
                output_file.write(modified_header)
            else:
                output_file.write(line)

def main():
    parser = argparse.ArgumentParser(description="Append gene information to sequence headers in a fasta file.")
    parser.add_argument("blastp_file", help="Path to the BLASTP output file.")
    parser.add_argument("msa_file", help="Path to the MSA file.")
    parser.add_argument("output_file", help="Path for the output file.")
    
    args = parser.parse_args()
    
    blastp_mapping = parse_blastp_output(args.blastp_file)
    
    modify_alignment_file(blastp_mapping, args.msa_file, args.output_file)

if __name__ == "__main__":
    main()
