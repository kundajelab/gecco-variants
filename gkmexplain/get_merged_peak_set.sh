#!/bin/bash

prefix="/srv/scratch/annashch/gecco/SVM"
zcat $prefix/C_merged_bam_rep1-pr.naive_overlap.filt.narrowPeak.gz $prefix/hct116_rep1-rep2.naive_overlap.filt.narrowPeak.gz  $prefix/V_merged_bam_rep1-pr.naive_overlap.filt.narrowPeak.gz $prefix/colo205_rep1-pr.naive_overlap.filt.narrowPeak.gz $prefix/sw480_ppr.naive_overlap.filt.narrowPeak.gz | bedtools sort -i | cut -f1,2,3 | uniq > gecco.overlap.bed 

