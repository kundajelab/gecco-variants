#!/bin/bash

QUERY=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/cohen
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output

bedtools intersect -wa -wb \
	-a $QUERY \
	-b $DATADIR/GSM2058024_Crypt5_H3K27ac_peaks.bed.gz $DATADIR/GSM2058022_C29_H3K27ac_peaks.bed.gz $DATADIR/GSM2058021_C28_H3K27ac_peaks.bed.gz $DATADIR/GSM2058023_C37_H3K27ac_peaks.bed.gz \
	-names Crypt5 C29 C28 C37 \
	-sorted > $OUTDIR/colon_crypt_h3k27ac_overlap.tsv
