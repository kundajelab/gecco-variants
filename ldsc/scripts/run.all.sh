#format GECCO gwas as needed by LDSC 
munge.sh
annotated_with_rsid.sh
  Runs: annotated_with_rsid.py
merge.sh

#run liftOver on hg38 peak sets (HTAN + ENCODE scATAC datasets) 
lift_peaks.sh

#get peak-set specific hertiability partitioning
tissue_specific_snp_annotation_single_cell.R
ldscore_singlecell.sh
cell_type_spe_regression.sh

#optionally, use Mike Gloudemans' plotting script to visualize 
plot_cellspecific_enrichments.R

