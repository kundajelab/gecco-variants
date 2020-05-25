#!/bin/bash
bedtools intersect -wa -sorted -b /srv/scratch/annashch/gecco/peaks/all.dnase.peaks.merged.bed -a /oak/stanford/groups/akundaje/projects/GECCO/annotated_colorectal_cancer_gwas_summary_statistics/all.formatted.bed > gecco.snps.in.dnase.peaks.bed
