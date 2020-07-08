#!/bin/bash

QUERY=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/atac_seq
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output

bedtools intersect -wa -wb \
	-a $QUERY \
	-b $DATADIR/Fr_1.R1.trim.PE2SE.nodup.tn5.pf.filt.narrowPeak.gz $DATADIR/Fr_2.R1.trim.PE2SE.nodup.tn5.pf.filt.narrowPeak.gz $DATADIR/Fr3_1.R1.trim.PE2SE.nodup.tn5.pf.filt.narrowPeak.gz $DATADIR/Fr_4.R1.trim.PE2SE.nodup.tn5.pf.filt.narrowPeak.gz \
	-names Fr_1 Fr_2 Fr3_1 Fr_4 > $OUTDIR/normal_mucosa_ATACseq_overlap.tsv
