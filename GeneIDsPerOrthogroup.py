import argparse
import pandas as pd

def count_gene_ids_per_orthogroup(matrix_csv, output_csv):
    # Load the matrix from CSV
    matrix = pd.read_csv(matrix_csv, index_col=0)
    
    # No need to transpose; gene IDs should be in columns and orthogroups in rows already
    # Convert to binary presence/absence
    binary_matrix = matrix.gt(0).astype(int)
    
    # Count gene IDs per orthogroup (sum along rows)
    gene_ids_count = binary_matrix.sum(axis=0)

    # Convert to DataFrame to prepare for CSV
    gene_ids_count_df = gene_ids_count.to_frame()
    gene_ids_count_df.columns = ['Gene_IDs_Count']

    # Save to CSV
    gene_ids_count_df.to_csv(output_csv)

def main():
    parser = argparse.ArgumentParser(description='Count Gene IDs per orthogroup.')
    parser.add_argument('matrix_csv', type=str, help='Input CSV file with the original matrix data')
    parser.add_argument('output_csv', type=str, help='Output CSV file for the count matrix')

    args = parser.parse_args()

    # Generate the count matrix
    count_gene_ids_per_orthogroup(args.matrix_csv, args.output_csv)

if __name__ == '__main__':
    main()
