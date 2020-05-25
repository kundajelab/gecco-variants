#!/bin/bash
split=$1
cell=$2 
prefix=/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores
gkmexplain  $prefix/fasta/$split.gecco.snps.in.dnase.peaks.1kb.fa $prefix/models/model.$cell.$split.model.txt $prefix/out/gkmexplain.$cell.$split.txt


