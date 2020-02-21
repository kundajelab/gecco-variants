#!/bin/bash
module load cellranger-atac
sample=$1
sample_folder=$2
outdir=$3
in=$sample_folder/$sample
#out=$outdir/$sample
cellranger-atac count  --id $sample --fastqs=$in --localcores=40 --reference /mnt/data/annotations/cellranger-atac/refdata-cellranger-atac-GRCh38-1.2.0

