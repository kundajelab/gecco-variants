#!/bin/bash

QUERY=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/cohen
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output

bedtools intersect -wa -wb \
	-a $QUERY \
	-b $DATADIR/GSM2058015_C31_DNase_peaks.bed.gz $DATADIR/GSM2058016_C34_DNase_peaks.bed.gz $DATADIR/GSM2058017_C36_DNase_peaks.bed.gz \
	-names C31 C34 C36 \
	-sorted > $OUTDIR/colon_crypt_DHS_overlap.tsv
