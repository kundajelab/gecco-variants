#!/bin/bash
indir="/oak/stanford/groups/akundaje/projects/GECCO/colorectal_cancer_gwas_summary_statistics"
outdir="/oak/stanford/groups/akundaje/projects/GECCO/ldsc_colorectal_cancer_gwas_summary_statistics"

#hapmap_fn not used because the gecco SNP names do not match the hapmap rsid numbers 
#hapmap_fn='/srv/scratch/annashch/gecco/ldsc_htan/w_hm3.snplist'

#GECCO codes Allele1 as the effect allele & Allele2 as the non-effect allele; ldsc does the opposite, hence --a1 maps to Allele 2 and --a2 maps to Allele1
for chrom in `seq 1 22`
do
    munge_sumstats.py --sumstats $indir/METAANALYSIS_JOINT_CHR$chrom\_1_SORTED.tbl \
		      --N-cas 58131  \
		      --N-con 67347 \
		      --out $outdir/munged.METAANALYSIS_JOINT_CHR$chrom\_1_SORTED.tbl \
		      --snp MarkerName \
		      --a1 Allele2 \
		      --a2 Allele1 \
		      --p P-value \
		      --signed-sumstats Zscore,0 \
		      --frq Freq1
done
