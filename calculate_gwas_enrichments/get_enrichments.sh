#!/bin/bash
python get_enrichments.py --peak_overlap_bed_files overlap/overlap*narrowPeak \
       --gwas_all_bed all.formatted.bed.expanded \
       --outf enrichments.txt

