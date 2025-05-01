import os
from Bio import AlignIO
from Bio.Align import MultipleSeqAlignment
import argparse

def filter_majority_gene_sequences(input_directory, txt_file, output_directory, log_file):
    # Open the log file
    with open(log_file, 'w') as log:
        
        # Load the text file manually
        try:
            with open(txt_file, 'r') as f:
                lines = f.readlines()
        except Exception as e:
            log.write(f"Failed to read txt file {txt_file}: {e}\n")
            return
        
        # Ensure output directory exists
        if not os.path.exists(output_directory):
            os.makedirs(output_directory)
        
        # Process each line in the text file
        for line in lines:
            parts = line.strip().split(',')
            orthogroup = parts[0]
            gene_data = parts[1:]
            
            # Write to log to check the gene_data content
            log.write(f"Processing orthogroup: {orthogroup}, gene_data: {gene_data}\n")
            
            if not gene_data or len(gene_data) < 2:
                log.write(f"No valid gene data for orthogroup {orthogroup}\n")
                continue

            # Extract the majority gene ID (first gene ID after the orthogroup)
            gene_data_list = [gene_data[i] for i in range(0, len(gene_data), 2)]
            percentages = [gene_data[i+1] for i in range(0, len(gene_data), 2)]
            
            # Write to log to check the gene_data_list and percentages content
            log.write(f"gene_data_list: {gene_data_list}\n")
            log.write(f"percentages: {percentages}\n")

            if len(gene_data_list) < 1:
                log.write(f"Invalid gene data for orthogroup {orthogroup}\n")
                continue
            
            majority_gene_id = gene_data_list[0]
            
            # Write to log to check the majority_gene_id
            log.write(f"majority_gene_id: {majority_gene_id}\n")
            
            # Find the corresponding alignment file
            input_file = None
            for filename in os.listdir(input_directory):
                if filename.startswith(orthogroup) and filename.endswith('.fa'):
                    input_file = os.path.join(input_directory, filename)
                    break
            
            if not input_file:
                log.write(f"Alignment file for orthogroup {orthogroup} not found.\n")
                continue
            
            # Read the alignment file
            try:
                alignment = AlignIO.read(input_file, "fasta")
            except Exception as e:
                log.write(f"Failed to read {input_file}: {e}\n")
                continue
            
            # Filter the sequences
            filtered_sequences = [record for record in alignment if majority_gene_id in record.description]
            
            # Convert the filtered sequences to a MultipleSeqAlignment object
            filtered_alignment = MultipleSeqAlignment(filtered_sequences)
            
            # Write the filtered sequences to a new file
            output_file = os.path.join(output_directory, f"{orthogroup}_Dclean_GeneSymbols_GeneIDs_MajorityOnly.fa")
            with open(output_file, 'w') as output_handle:
                AlignIO.write(filtered_alignment, output_handle, "fasta")
            
            log.write(f"Processed {orthogroup}, saved filtered sequences to {output_file}\n")

def main():
    parser = argparse.ArgumentParser(description='Filter sequences by majority GeneID.')
    parser.add_argument('input_directory', type=str, help='Directory containing the alignment files')
    parser.add_argument('txt_file', type=str, help='Comma-separated text file with orthogroup and GeneID data')
    parser.add_argument('output_directory', type=str, help='Directory to save the filtered alignment files')
    parser.add_argument('log_file', type=str, help='File to save the log output')
    
    args = parser.parse_args()
    
    # Filter the sequences based on majority GeneID
    filter_majority_gene_sequences(args.input_directory, args.txt_file, args.output_directory, args.log_file)

if __name__ == '__main__':
    main()
