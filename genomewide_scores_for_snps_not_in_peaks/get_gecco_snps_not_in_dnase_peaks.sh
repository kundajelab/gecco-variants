#!/bin/bash

bedtools intersect -v -a /oak/stanford/groups/akundaje/projects/GECCO/annotated_colorectal_cancer_gwas_summary_statistics/all.formatted.bed -b ../genomewide_scores/gecco.snps.in.dnase.peaks.bed > gecco.snps.not.in.dnase.peaks.bed

