# Remove_Paralogs_After_Orthofinder
A set of custom scripts and steps to cleanup, sort, and remove paralogs and identify single copy orthologs from Orthofinder output


#####################################################################################################
This part of the pipeline filters a list of MSAs from orthofinder based on species presence and gap % (iteratively)
#####################################################################################################
##Starting OGs 67k
##STEP1--- Remove orthogroups with too few focal and background species 
##This script makes a csv of number of cavefish and total number of fish in each orthogroup 

CountCFandTOTALSpecies.py
CountCFandTOTALSpecies.sh

###Download output CSV and sort by # cavefish keep OGs that >7 cavefish, >30 background species. 
####Copy OG file names to a txt file and cp OGs to a new directory 

###STEP2--- Clean up alignments with long trailing ends and gaps
##### This is a cleanup script
#Trims a sequence to start at a codon which is present in 75% of sequences, and gets rid of any sequence that is >50% gaps. Note changing .5 to .75 would mean you get rid of sequence that is >25% gaps (its inverted).

Prot_CLEANUP_ALNS_LOOP.py
Prot_CLEANUP_ALNS_LOOP.sh


##After cleaning step1 repeat species count and once again keep OGs that >7 FOCAL SPECIES, >30 BACKGROUND SPECIES
output 

Example Output: 
RESULT: 12927 high qual MSAs


#########################################################################
These scripts takes as input a directory with multiple sequence alignments (output flag -msa from orthofinder) and unaligns them so they can be used as input for blast to ID each sequence by GeneSymbol
########################################################################

### UNALIGN MSAs### This script takes the alignment files (all in a directory) and removes "-" making these sequence lists rather than alignments for blast inpu 

DeleteDashes.sh

### Then we start to blast
#Here is a blastDB for Danio rerio from Ensembl
/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/Proteomes

####Now we need to blast each orthogroup seq list (formerly MSAs) 
locale: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/
BLAST1_array.sh
runarrays.sh

Output here: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x_unaligned/BlastP_Results/

######################################################################
Ammend Gene symbols to all sequences in the folder aptly named /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/MakingAlignmentsWithGeneSymbolsFromBlast/
#################################################################

append_gene_symbols.py
append_gene_symbols.sh
runarrays.sh
##This will add the gene symbol for the top hit from each seqeunce from the BlastP results to the original MSAs (but not overwrite them, write them to a new directory)
Output here: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/Alignments_withGeneSymbols/


###########################
Do some quantifying
##########################
Again, in the aptly named folder /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/QuantifyGeneSymbolsInMSAs

##These scripts will make a matrix of orthogroups (MSAs) vs gene symbol counts
QuantifyGeneSymboks_matrix.sh
QuantifyGeneSymbols_matrix.py

Output: 12kGeneSymbolMatrix.csv

####These scripts use that matrix to count presence of a gene symbol across orthogroups

GeneSymbolsPerOrthogroup.py
GeneSymbolsPerOrthogroup.sh

output: GeneSymbolsPerOrthogroup.csv
RESULT:
7041 OGs with 1 gene symbol
3400 with 2 
The remainder ~2500 have 3+ 


###These script do the opposite: 
OrthogroupsPerGeneSymbol.py  #DAMNIT I DELETED THE CORRECT VERSION OF THIS, this is the stupid graph script
OrthogroupsPerGeneSymbol2.sh

output: OrthogroupsPerGeneSymbol.csv
RESULT: 
20275 gene symbols 
3478 gene symbols are in >1 orthogroup
16,797 gene symbols occur only in one orthogroup

#################################################################
Append Gene IDs to the Alignments 
#################################################################

Locale: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/MakingAlignmentsWithGeneSymbolsFromBlast
append_gene_IDs.py
append_gene_IDs.sh

##This script appends the "gene:" information from the blastP file to the alignments that already have "gene_symbol:" information on it
##Note: This script uses the OG# by parsing the file name by the first underscore
##Gene ID is added with a double __


Alignments with GeneIDs and Gene Symbols here: 
/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/1AlignmentswithGeneSymbandGeneIDs/

######################################################################
NOW DO SOME MORE QUANTIFYING WITH GENE_IDS
#####################################################################

#####These will make the same matrix as above with GeneIDs vs orthogroups 
Locale: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/QuantifyGeneSymbolsInMSAs
QuantifyGeneIDs_matrix.py
QuantifyGeneIDs_matrix.sh

Output: 12kGeneIDsMatrix.csv


#### Make a matrix from that giant matrix of # of gene IDs per orthogroup
GeneIDsPerOrthogroup.py
GeneIDsPerOrthogroup.sh

output: GeneIDsPerOrthogroup.csv

##### Make a matrix of number of orthogroups for each gene ID 
OrthogroupsPerGeneID.py
OrthogroupsPerGeneID.sh

Output: OrthogroupsPerGeneID.csv

############This script makes a file that makes a csv of each orthogroup with the GeneID next to it and the percentage of the sequences for each gene ID 
PercentageGeneIDs.py
PercentageGeneIDs.sh

PercentageGeneIDs.csv

##########Notable Results: 

5254 orthogroups are 100% one GeneID
2400 >90% one GeneID
3590 >50% one GeneID
Total >50%= 11244

Garbagey orthogroups: 1683

###################################################################################
Directory Organization 
###########################################################

##This was getting cumbersone so I organized/changed directories (note that the scripts above will need to update with the correct paths 

Clean Alignments master directory /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/

###Subdirectory starting with 1 (e.g. 1CleanAlignments) has the alignment files 
###Subdirectory starting with 2 (e.g: 2Alignments_withGeneSymbols has the alignment files from subdirectory 1 processed with the next step) click on this subdirectory to get to the next step

###This way all original alignments are retained with each processing step intact, but one does not have to click through 5 directories with 13k .fa files in it (and load each time) to navigate through files

##################################################################
Now we need to filter the alignments to contain only the GeneID that reprisents the majority of the sequences
#################################################################

Script Locale: 
/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Filter_Alignments_ByGeneID
##This script takes the percentage Gene ID file and uses it to filter out any GeneIDs that are not from the majority GeneID--- It re-writes the alignments (leaving the originals intact) to a new directory

MajorityGeneIDs.py
MajorityGeneIDs.sh
PercentageGeneIDs.txt

## Output :/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/2MajorityGeneID_alignments
##Tagged _MajorityOnly
###NOTE: These will need to be made into sequence lists and re-alinged, but going to deal with that downstream*****

###################################################################
Quanitfy how many alignments are single-copy
######################################################################

Lets just use a new directory /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Count_Duplications_in_Alignments

CountDupsInAlns.py
CountDupsInAlns.sh
Species_List.txt

#####This one counts total species and cavefish species : 
Cavefish_List.txt
CountDupsInAlns_andSPCount.py
CountDupsInAlns_andSPCount.sh
Species_List.txt

Output: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Count_Duplications_in_Alignments/CountDupesANDspecies.csv

##Download this file and sort for Cavefish (keep >7 cavefish), then sort for total species >30 

Remaining: 12172 alignments

File: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Count_Duplications_in_Alignments/Greater30BG_Greater7CF_majorityGeneID_alns.csv

######################################
Re-align with MACSE 
######################################

Majority Alns: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/2MajorityGeneID_alignments

Script Locale: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/MACSE_alignmentScripts

##scripts run MACSE using arrays for all 12k alignments, re-aligns and puts in a new subdir with _realigned.fa tag
MACSE_arrayScript.sh
runarrays.sh

#######################################
Make TREES
#######################################

Script locale : 
/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/IQTREE_scripts/

IQTREE_array.sh #This runs IQTREE
runarrays1.sh #This runs the previous script 12k times using arrays of 2k at once

################
SOMETHING WENT WRONG
#################

------- some files are missing, and some are empty
why----- I seem to have failed to actually filter the majority alignments for ones with >30 bg and >7 cf and instead ran everything. GREAT JOB DUMMY

GO BACK AND FILTER
locale: 
/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Count_Duplications_in_Alignments

this script 
MoveTreeFiles.sh #uses this list Orthogroups_with30BGand7CF_majority.txt to move all the tree files that are from this list to a new directory, there should be 12172

BUT there's only 11534--- (638 missing) 

Use this script to find OGs missing from the iqtree files: locale /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Count_Duplications_in_Alignments/
CheckTreeFileOGs.sh

There are 637 OGs missing, listed here: MissingOGfromTrees.txt

where did they go...?
Well, the alignments are all there... 
623 of the alignment files are empty

1) 14 alignment files are present but have no tree but are not empty: simply re-run these... 
###missing_in_file2_IQTREES_Missing_but_notoneoftheemptyalnfiles.txt

2) why are the MAFFT files empty? christ almightly --- there are some U characters --- solution run mafft --anysymbol for the missing alignments. 

##re-run using a simple script now MSI arrays aren't working, and also I seem to have been bumped from shared nodes >( 

/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/MAFFT_alingment_Scripts/MAFFT_SIMPLE.sh

##Missing Alignments here: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/1HighQualFilterMSAs_CleanANDFiltered2x/2Alignments_withGeneSymbols/2Alignments_GeneSymbolsANDGeneIDs/2MajorityGeneID_alignments/1MajorityGeneID_alignments/MissingAlns/ReAligned_missingalns
623 total 

####################
OKAY LETS CHECK HOW MANY ALIGNMENTS AND TREES I HAVE NOW AND SEE IF WE CAN MOVE TO ORTHOSNAP
####################
15 trees still missing: 
OG0003906-- zyg11__ENSDARG00000007737.10
OG0004232-- trps1__ENSDARG00000104082.2
OG0004269-- BLTP1__ENSDARG00000062330.7
OG0004304-- tlr7__ENSDARG00000075685.4
OG0006415-- mthfr__ENSDARG00000053087.7
OG0006968-- ttc7a__ENSDARG00000074760.5
OG0007509-- npas2__ENSDARG00000116993.1
OG0007536-- anapc2__ENSDARG00000105035.2
OG0007781-- DXO__ENSDARG00000036852.6  #### THIS ONE IS MISSING FROM PRE_ALNed?
OG0007916-- slf2__ENSDARG00000003328.11
OG0009218-- tasor2__ENSDARG00000074168.7
OG0009492-- kansl1l__ENSDARG00000075284.5
OG0010798-- myo19__ENSDARG00000073761.4
OG0011376-- aasdh__ENSDARG00000022730.11

###Running iqtree interactively -- some sequences are too short--- it looks like MAFFT was stopped mid-run, need to re-run alignment. 
###ERROR: Sequence Teleost_Euteleost_Istiophoriformes_Xiphidae_Xiphias_gladius_XP_039977945.1__trps1__ENSDARG00000104082.2 contains not enough characters (1026)

###############################################
Fixed all of the above issues and ran orthosnap July 2024
##################################################

Input Alignments: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Orthosnap/OrthoSnapFormatedAlns
Input Trees: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Orthosnap/TreesFormattedForOrthosnap

12171 trees of protein alignments with at least 7 species of cavefish and at least 30 background (non-cavefish species) 

Orthosnap results: /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Orthosnap/OrthoSnapResults_round1

ALIGNMENTS: 4549 

########################Next step is filtering these for ones that retain at least 7 cavefish and 30 background species
##########################aaand this is a bust--- See the CSV /panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Orthosnap/OrthoSnapMSA_SpeciesCOUNT.csv
########################################## no MSAs filtered by orthosnap retain more than 2 cavefish species--- most are 0. 


###############Orthosnap on the 12k is a bust--- resturn to the 12k genes and find how many copies per species there are###################################

STEP1: AddGeneID and GENESymboks to filenames for easy access

/panfs/jay/groups/26/mcgaughs/drabe004/BIGFISHGENOME_DataRespository/Protein_Alignments_and_GeneTrees_multicopy

RenameMSAs_geneIDandGensymbol.py
RenameMSAs_geneIDandGensymbol.sh


STEP2: Count copies of genes in each MSA: 
/panfs/jay/groups/26/mcgaughs/drabe004/BIGFISHGENOME_DataRespository/Protein_Alignments_and_GeneTrees_multicopy

CopyNumberCount.py
CopyNumberCount.sh

RESULTS: /panfs/jay/groups/26/mcgaughs/drabe004/BIGFISHGENOME_DataRespository/CopyNumberData125Genomes/CopyNumber.csv

##################################Statistical tests of which genes have more or less copies in cavefish vs other species. 
Doing this in R locally


1857 genes that are have significantly more or fewer copies in cavefish

##########################################################Using the ncbi ortholog database to fill out the dataset ######################
##############################################################
#####USE THE GENE SYMBOLS TO GET ORTHOLOGS FROM THE ORTHOLOG DATABASE
##Gene symbols extracted from: /panfs/jay/groups/26/mcgaughs/drabe004/BIGFISHGENOME_DataRespository/CopyNumberData125Genomes/CopyNumber.csv

locale: /panfs/jay/groups/26/mcgaughs/drabe004/NCBI_Datasets/Download_All_OrthologDatasets.sh


##Download all of the datasets

Download_All_OrthologDatasets.sh

##Rename the directories and the file names

RENAME_OrthologDatasets.py
RENAME_OrthologDatasets.sh

##Generate TSVs per NCBI's instruction https://www.ncbi.nlm.nih.gov/datasets/docs/v2/tutorials/ortholog-get-one-isoform/#:~:text=This%20can%20be%20done%20in,transcript%20sequences%2C%20one%20per%20gene

GenerateTSVs_Datasets.sh

####Get lists of the longest transcripts from the TSVs

GetLongestTranscript.sh
################################################################
6512 gene symbols have a list of entries for Teleost in NCBI orthologDB 

#######################################################################

#Make custom Web-Scraping script to get the single copy transcript and protein files: /panfs/jay/groups/26/mcgaughs/drabe004/NCBI_Datasets/ManipulateGUI

#OK jumping around a little here but stay with me-- 

#Here is the batch script to download from NCBI--- I am using a Selenium package to manipulate the NCBI website (this is basically a bot). The reason I did it this way was that after meeting with NCBI to figure out how they make these lists... I was unconvinced that the method they suggested would reliably recreate what is available on the GUI. Sadly--- there is not a straightforward way to access this data via the API. 

#This one is for proteins and just a warning that via the API I know that there are about 6100 protein lists, this returns about 4700--- so its not error free (still working on that). I included a version that takes screenshots at each step so you can troubleshoot if you have missing ones too *Sorry I had meant to get to this, but teaching took over* 

#As input you need a text file with the gene symbol names (for insane complicated and kinda dumb reasons you cannot you gene IDs)

#Tricky bits: 
#1) Everything is hard coded--- and I swear it's not because I'm a newb :-P. For some reason when you're driving a browser in headless mode, it has trouble updating input indirectly from a bash. I don't know why and I gave up trying to figure out why--- but if you just hard code everything (paths files names etc) it works! 

#2) Update the Scope
###This is a shortcut to making sure you're in the right species group. Each species group has a scope number, so you should manually update this in the code (you can just fine this on the website when you go to the species)
# Step 4: Update scope to Teleost Fish
            try:
                teleost_url = f"{current_url.split('?')[0]}?scope=32443"
                driver.get(teleost_url)
                WebDriverWait(driver, 30).until(EC.url_contains("scope=32443"))
                driver.save_screenshot(os.path.join(output_dir, f"{gene_symbol}_step4_scope.png"))
            except Exception as e:
                logging.error(f"Error updating scope for gene symbol {gene_symbol}: {e}")
                driver.save_screenshot(os.path.join(output_dir, f"{gene_symbol}_error_scope.png"))
                with open(os.path.join(output_dir, f"{gene_symbol}_scope_error_source.html"), "w") as file:
                    file.write(driver.page_source)
                continue
##Proteins
/panfs/jay/groups/26/mcgaughs/drabe004/NCBI_Datasets/ManipulateGUI/ncbi_debug9.3_Screenshhots_proteins.py

#CDS
/panfs/jay/groups/26/mcgaughs/drabe004/NCBI_Datasets/ManipulateGUI/ncbi_debug9_transcripts.py


#####################################################
##Skipping backwards to rerun Orthofinder with a lower branch collapsing threshold: 

/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Orthosnap/Orthosnap_array.sh
##run with: 
/panfs/jay/groups/26/mcgaughs/drabe004/Orthofinder_Datasets/125_Species_OFFICIALDATASET/OrthoFinder/Results_Jun27/Orthosnap/runarrays2.sh

###This produced no output for any orthogroups
##Tried again to drop the species threshold to 30. 




