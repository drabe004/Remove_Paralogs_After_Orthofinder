import sys
import os
from Bio import AlignIO
from Bio.Align import MultipleSeqAlignment
import logging

def trim_alignment_to_threshold(alignment, initial_threshold, secondary_threshold):
    sequence_length = alignment.get_alignment_length()
    codon_length = 1  # In protein alignments, each position is a single amino acid
    for threshold in [initial_threshold, secondary_threshold]:
        for i in range(0, sequence_length, codon_length):
            column = alignment[:, i:i+codon_length]
            presence = sum(1 for aa in column if "-" not in aa) / len(alignment)
            if presence >= threshold:
                return alignment[:, i:]
    logging.info(f"No columns met the {secondary_threshold*100:.0f}% presence requirement. Proceeding with the original alignment for {alignment[0].id}.")
    return alignment

def remove_species_with_high_gap_percentage(alignment, threshold):
    total_length = alignment.get_alignment_length()
    new_records = []
    
    for record in alignment:
        sequence = str(record.seq)
        gap_percentage = sequence.count('-') / total_length
        if gap_percentage <= threshold:
            new_records.append(record)
    
    return MultipleSeqAlignment(new_records)

if __name__ == "__main__":
    if len(sys.argv) != 6:
        print("Usage: python script.py input_directory output_directory gap_threshold initial_threshold secondary_threshold debug_logfile")
        sys.exit(1)
    
    input_directory = sys.argv[1]
    output_directory = sys.argv[2]
    gap_threshold = float(sys.argv[3])
    initial_threshold = float(sys.argv[4])
    secondary_threshold = float(sys.argv[5])
    debug_logfile = sys.argv[6]
    
    logging.basicConfig(filename=debug_logfile, level=logging.INFO)
    
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)
    
    for filename in os.listdir(input_directory):
        if filename.endswith(".fa"):
            input_file_path = os.path.join(input_directory, filename)
            output_file_path = os.path.join(output_directory, filename.replace(".fa", "_Dclean.fasta"))
            
            alignment = AlignIO.read(input_file_path, "fasta")
            trimmed_alignment = trim_alignment_to_threshold(alignment, initial_threshold, secondary_threshold)
            final_alignment = remove_species_with_high_gap_percentage(trimmed_alignment, gap_threshold)
            
            with open(output_file_path, "w") as output_handle:
                AlignIO.write(final_alignment, output_handle, "fasta")
    
    print("Alignment processing complete.")
