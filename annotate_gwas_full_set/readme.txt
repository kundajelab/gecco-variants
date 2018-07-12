# use maek_bed.py to generate bed files from GWAS. returns:
# name
# chrom
# SNP pos
# SNP pos+1
# allele 1
# allele 2
# allele freq
# allele pval
# % GC within specified window

#pass outputs to :
# 1. bedtools intersect with TSS file to get closest gene
# 2. bedtools intersect with accessions from screen (in memory) to avoid massive number of tmp files

#aggregate into a single file per chromosome with the above summary statistics

# use the aggregate summary stats to compute enrichments for tissue_state in 99% credible set relative to all SNPs
# use the aggregate summary stats to select matched negatives for the MPRA pilot
