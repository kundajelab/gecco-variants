###############################################################
# This is where the LD score regression actually happens
#
# NOTE: If you want to add additional peak groups, you need
# to edit the *.ldcts files to include the relevant files
# (the format is intuitive, take a look at the existing files
# for an example)
###############################################################
unset DISPLAY XAUTHORITY
export sumstats_fn="/oak/stanford/groups/akundaje/projects/GECCO/ldsc_colorectal_cancer_gwas_summary_statistics/munged.txt.gz"
# Load pre-munged GWAS sumstats files, in LDSC format
# Input data and settings
export config_dir='/srv/scratch/annashch/gecco/ldsc_htan/config_partition_heritability_merged'
export tissue_specific_annotation_dir='/srv/scratch/annashch/gecco/ldsc_htan/tissue_specific_snp_annotation'
export weight_dir="/mnt/data/ldscore/weights_hm3_no_hla"
export frq_dir="/mnt/data/ldscore/1000G_frq"
export baseline_annotation_dir='/mnt/data/ldscore/baseline'
# Output directory
export out_dir='/srv/scratch/annashch/gecco/ldsc_htan/partition_heritability_merged/'

cell_type_SPE(){
    mkdir -p $2
    echo INFO - in_dir: $1
    echo INFO - out_dir: $2
    echo INFO - trait: $3
    echo INFO - gwas: $4
    echo INFO - ldcts: $5
    if [[ -e "$2/$3.merged.results" ]]; then	
	echo "INFO - Already finished. Skipping."
	return 0	
    fi 
    ldsc.py \
	--h2-cts $4 \
	--ref-ld-chr $baseline_annotation_dir/baseline. \
	--out $2/$3.merged \
	--ref-ld-chr-cts $5 \
	--w-ld-chr $weight_dir/weights.
}

export -f cell_type_SPE
for gwas in $sumstats_fn 
do
    # IDR peaks
    cell_type_SPE \
	$tissue_specific_annotation_dir \
	$out_dir \
	`basename $gwas` \
	$gwas \
	$config_dir
done
