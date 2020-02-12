#!/bin/bash
python get_enrichments.py --peak_overlap_bed_files overlap/overlap* \
       --gwas_all_bed all.formatted.bed.expanded \
       --outf enrichments.txt \
       --threads 40 \
       --increment 0.1 


