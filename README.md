# Orthofinder Cleanup and Single-Copy Ortholog Identification Pipeline

A custom pipeline to clean, filter, and annotate Orthofinder results in order to identify high-quality single-copy orthologs across multiple species.

---

## Step 1: Filter Orthogroups by Species Presence

**Goal**: Retain orthogroups with sufficient representation across focal (cavefish) and background species.

- Scripts:
  - `CountCFandTOTALSpecies.py`
  - `CountCFandTOTALSpecies.sh`

**Instructions**:
- Run the script to generate a CSV of cavefish and total species per orthogroup.
- Retain orthogroups with >7 cavefish and >30 background species.
- Copy selected OGs to a new directory.

---

## Step 2: Clean Alignments (Gap and Trailing End Removal)

**Goal**: Improve alignment quality by removing poorly aligned sequences.

- Scripts:
  - `Prot_CLEANUP_ALNS_LOOP.py`
  - `Prot_CLEANUP_ALNS_LOOP.sh`

**Method**:
- Trim sequences to start at a codon present in 75% of sequences.
- Remove sequences with >50% gaps.
- Re-filter orthogroups using Step 1 criteria.

**Result**: ~12,927 high-quality MSAs.

---

## Step 3: Unalign MSAs for BLAST Input

**Goal**: Convert aligned MSAs to raw sequence lists.

- Script: `DeleteDashes.sh`

**Method**: Remove all "-" characters from sequences in each alignment file.

---

## Step 4: BLAST Unaligned Sequences to Identify Gene Symbols

- Scripts:
  - `BLAST1_array.sh`
  - `runarrays_BLAST1.sh`

**Input**:
- Ensembl-based custom protein database (e.g., Danio rerio).
- List of unaligned orthogroup files.

**Output**: BLAST results with standard format (-outfmt 6).

---

## Step 5: Append Gene Symbols to FASTA Headers

- Scripts:
  - `append_gene_symbols.py`
  - `append_gene_symbols.sh`
  - `RunArrays.sh`

**Input**:
- `BlastPOutputList.txt`
- `Results_Jun27ListOfAlignmentsbeforeBlast.txt`

**Output**: FASTA files with appended gene symbols, saved to `Alignments_withGeneSymbols/`.

---

## Step 6: Quantify Gene Symbol Distributions

- Scripts:
  - `QuantifyGeneSymbols_matrix.py`
  - `QuantifyGeneSymboks_matrix.sh`
  - `GeneSymbolsPerOrthogroup.py`
  - `GeneSymbolsPerOrthogroup.sh`

**Output**:
- `12kGeneSymbolMatrix.csv`
- `GeneSymbolsPerOrthogroup.csv`

**Stats**:
- 7041 OGs have 1 gene symbol
- 3400 have 2 gene symbols
- ~2500 have 3+

---

## Step 7: Quantify Orthogroups per Gene Symbol

- Scripts:
  - `OrthogroupsPerGeneSymbol.py`
  - `OrthogroupsPerGeneSymbol2.sh`

**Output**: `OrthogroupsPerGeneSymbol.csv`

**Stats**:
- 20,275 unique gene symbols
- 3,478 in >1 orthogroup
- 16,797 in exactly one orthogroup

---

## Step 8: Append Gene IDs to Alignments

- Scripts:
  - `append_gene_IDs.py`
  - `append_gene_IDs.sh`

**Note**: Appends `gene:` field to headers in files already containing `gene_symbol:`.

---

## Step 9: Quantify Gene ID Distributions

- Scripts:
  - `QuantifyGeneIDs_matrix.py`
  - `QuantifyGeneIDs_matrix.sh`
  - `GeneIDsPerOrthogroup.py`
  - `GeneIDsPerOrthogroup.sh`
  - `OrthogroupsPerGeneID.py`
  - `OrthogroupsPerGeneID.sh`
  - `PercentageGeneIDs.py`
  - `PercentageGeneIDs.sh`

**Output Files**:
- `12kGeneIDsMatrix.csv`
- `GeneIDsPerOrthogroup.csv`
- `OrthogroupsPerGeneID.csv`
- `PercentageGeneIDs.csv`

**Stats**:
- 5,254 OGs are 100% one GeneID
- 2,400 are >90% one GeneID
- 3,590 are >50% one GeneID
- 1,683 are considered low-quality / garbage

---

## Step 10: Filter Alignments to Keep Only Majority GeneID

- Scripts:
  - `MajorityGeneIDs.py`
  - `MajorityGeneIDs.sh`

**Note**: Retains only sequences matching the majority GeneID in each orthogroup.

---

## Step 11: Count Duplicates and Species Coverage

- Scripts:
  - `CountDupsInAlns.py`
  - `CountDupsInAlns.sh`
  - `CountDupsInAlns_andSPCount.py`
  - `CountDupsInAlns_andSPCount.sh`

**Filters**:
- >7 cavefish species
- >30 total species

**Input Lists**:
- `Cavefish_List.txt`
- `Species_List.txt`

**Result**: 12,172 alignments remain.

---

## Step 12: Realign MSAs with MACSE

- Scripts:
  - `MAFFT_arrayScript.sh` (note: script may be named for MAFFT but originally MACSE used)
  - `RunArrays.sh`

**Output**: Realigned files tagged with `_realigned.fa`

---

## Step 13: Generate Gene Trees with IQ-TREE

- Script: `IQTREE_Arrays.sh`

**Goal**: Infer high-quality gene trees for use with downstream tools like Orthosnap or GeneRax.

---

## Step 14: Integrate Orthologs from NCBI Ortholog Database

### Input
- `CopyNumber.csv` (gene symbols)
- `Download_All_OrthologDatasets.sh`

### File Processing
- `RENAME_OrthologDatasets.py`
- `GenerateTSVs_Datasets.sh`

**Result**: 6,512 gene symbols with NCBI ortholog data for Teleosts

### Selenium Scripts (Headless Browser)
- `ncbi_debug9.3_Screenshhots_proteins.py`
- `ncbi_debug9_transcripts.py`

**Tips**:
- Paths must be hard-coded due to browser behavior.
- Update scope manually to `Teleost` (scope ID = 32443).

