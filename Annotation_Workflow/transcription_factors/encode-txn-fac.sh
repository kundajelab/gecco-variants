#!/bin/bash

QUERY=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/encode
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output

bedtools intersect -a $QUERY -b $DATADIR/wgEncodeRegTfbsClusteredWithCellsV3.bed.gz -wb > $OUTDIR/TxnFac_overlap.tsv
