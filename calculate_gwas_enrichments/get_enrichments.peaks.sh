#!/bin/bash
python get_enrichments.py --peak_bed model_peaks/*gz roadmap_peaks/*gz \
       --gwas_thresh_bed gwas_thresh/pval_splits.-* \
       --gwas_all_bed gwas_thresh/pval_splits.bed \
       --outf gecco.gwas.enrichments.peaks.overlap.bed

