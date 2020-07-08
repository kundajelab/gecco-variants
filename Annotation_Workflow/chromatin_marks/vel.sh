#!/bin/bash

QUERY=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/cohen
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output

bedtools intersect -a $QUERY -b $DATADIR/cohen_vsl_gained.bed -wb > $OUTDIR/cohen_vsl_gained_overlap.tsv
bedtools intersect -a $QUERY -b $DATADIR/cohen_vsl_lost.bed -wb > $OUTDIR/cohen_vsl_lost_overlap.tsv
