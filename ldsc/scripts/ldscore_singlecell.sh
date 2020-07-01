
# Load data shared across all peak groups
export plink_dir='/mnt/data/ldscore/1000G_plinkfiles'
export OPENBLAS_NUM_THREADS=50

############################################################
# Cell type specific annotations,
# first for naive optimal peak calls and then for IDR
############################################################

# Load intermediate pre-processed files
export annot_dir='/srv/scratch/annashch/gecco/ldsc_htan/tissue_specific_snp_annotation'
# Output directory locations
export out_dir='/srv/scratch/annashch/gecco/ldsc_htan/ldsc_score_regression'
for x in "B-cells" "Best4pos-Enterocytes" "Crypt-Fibroblasts" "Endothelial" "Enterocytes" "Goblet" "Immature-Goblet1" "Immature-Goblet2" "Intestinal-Stem-Cells-LGR5pos" "Intestinal-Stem-Cells" "Mast-cells" "Monocytes" "Myofibroblasts2" "Myofibroblasts" "Stromal" "StromalOther" "T-cells" "Villus-Fibroblasts"
do 	
	seq 1 22 | parallel -j 1  "ldsc.py --l2 --bfile $plink_dir/1000G.mac5eur.{} --ld-wind-cm 1 --annot $annot_dir/$x.chr{}.annot --out $out_dir/$x.chr{}"
done
