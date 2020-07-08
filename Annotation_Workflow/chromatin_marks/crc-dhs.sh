#!/bin/bash

QUERY=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/cohen
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output

bedtools intersect -wa -wb \
	-a $QUERY \
	-b $DATADIR/GSM2058018_V389_DNase_peaks.bed.gz $DATADIR/GSM2058019_V410_DNase_peaks.bed.gz $DATADIR/GSM2058020_V576_DNase_peaks.bed.gz \
	-names V389 V410 V576 \
	-sorted > $OUTDIR/CRC_DHS_overlap.tsv
