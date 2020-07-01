#!/bin/bash
plink_dir='/oak/stanford/groups/akundaje/refs/ldscore/1000G_plinkfiles'
chrom=$1
annot=$2
out=$3
echo "ldsc.py --l2 --bfile $plink_dir/1000G.mac5eur.$chrom --ld-wind-cm 1 --annot $annot --out $out"
ldsc.py --l2 --bfile $plink_dir/1000G.mac5eur.$chrom --ld-wind-cm 1 --annot $annot --out $out

