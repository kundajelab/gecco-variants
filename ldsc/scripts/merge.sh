#!/bin/bash
outdir="/oak/stanford/groups/akundaje/projects/GECCO/ldsc_colorectal_cancer_gwas_summary_statistics"
cp ../header  $outdir/munged.txt
outdir="/oak/stanford/groups/akundaje/projects/GECCO/ldsc_colorectal_cancer_gwas_summary_statistics"
for chrom in `seq 1 22`
do
    cat $outdir/munged.rsid.$chrom.txt >>$outdir/munged.txt
    echo $chrom
done
gzip $outdir/munged.txt
