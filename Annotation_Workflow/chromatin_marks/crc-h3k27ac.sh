#!/bin/bash

QUERY=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input/ld_proxies_r2_80pct.bed
DATADIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/data/cohen
OUTDIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output

bedtools intersect -wa -wb \
	-a $QUERY \
	-b $DATADIR/GSM2058037_V411_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058028_V1009_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058027_SW480_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058029_V1024_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058030_V1051_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058031_V1058_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058032_V1074_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058034_V206_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058033_V1106_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058038_V429_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058045_V703_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058051_V968_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058039_V432_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058040_V456_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058042_V481_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058050_V940_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058043_V5_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058035_V389_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058047_V852_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058025_COLO205_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058052_V9P_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058049_V866_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058044_V576_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058046_V784_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058041_V457_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058036_V410_H3K27ac_peaks_FIXED.bed.gz \
           $DATADIR/GSM2058048_V855_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058026_HCT116_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058055_CRC_6A_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058056_CRC_7A_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058053_CRC_17A_H3K27ac_peaks.bed.gz \
           $DATADIR/GSM2058054_CRC_23A_H3K27ac_peaks.bed.gz \
	-names V411 \
               V1009 \
               SW480 \
               V1024 \
               V1051 \
               V1058 \
               V1074 \
               V206 \
               V1106 \
               V429 \
               V703 \
               V968 \
               V432 \
               V456 \
               V481 \
               V940 \
               V5 \
               V389 \
               V852 \
               COLO205 \
               V9P \
               V866 \
               V576 \
               V784 \
               V457 \
               V410 \
               V855 \
               HCT116 \
               CRC_6A \
               CRC_7A \
               CRC_17A \
               CRC_23A \
	-sorted > $OUTDIR/CRC_H3K27ac_overlap.tsv
