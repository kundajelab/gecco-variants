#!/bin/bash
python annotate_gwas.py --source_file /oak/stanford/groups/akundaje/lab_data/kundaje/projects/GECCO/colorectal_cancer_gwas_summary_statistics/METAANALYSIS_JOINT_CHR$1_1_SORTED.tbl \
    --chrom chr$1 \
    --flank_for_gc 100 \
    --tss_bed refGene_hg19_TSS.bed \
    --outf /oak/stanford/groups/akundaje/lab_data/kundaje/projects/GECCO/annotated_colorectal_cancer_gwas_summary_statistics/annotations.chr$1.bed \
    --screen_bed_dir /oak/stanford/groups/akundaje/refs/ENCODE/screen/bed_files \
    --ref_fasta /oak/stanford/groups/akundaje/refs/hg19.genome.fa \
    --screen_metadata /oak/stanford/groups/akundaje/refs/ENCODE/screen/screen_bed_files.txt
