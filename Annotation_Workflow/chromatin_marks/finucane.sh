#!/bin/bash

INPUT=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/finucane
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output/finucane_overlap

bedtools intersect -a $INPUT -b $DATADIR/1.bed > $OUTDIR/Adrenal_Pancreas_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/2.bed > $OUTDIR/Cardiovascular_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/3.bed > $OUTDIR/CNS_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/4.bed > $OUTDIR/Connective_Bone_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/5.bed > $OUTDIR/GI_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/6.bed > $OUTDIR/Hematopoietic_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/7.bed > $OUTDIR/Kidney_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/8.bed > $OUTDIR/Liver_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/9.bed > $OUTDIR/Other_overlap.tsv
bedtools intersect -a $INPUT -b $DATADIR/10.bed > $OUTDIR/SkeletalMuscle_overlap.tsv
