#!/bin/bash
class_vs_reg=classification
fold=0
task=0
CUDA_VISIBLE_DEVICES=3 kerasAC_interpret  \
		    --input_bed_file=/srv/scratch/annashch/gecco/gkmexplain/gecco.variants.in.overlap.peaks.bed \
		    --ref_col Ref \
		    --alt_col Alt \
		    --compute_gc \
		    --flank 500 \
		    --chrom_col Chrom \
		    --pos_col Pos0 \
		    --rsid_col Rsid \
		    --ref_fasta /mnt/data/male.hg19.fa \
		    --batch_size 1600 \
		    --load_model_hdf5 /srv/scratch/annashch/deeplearning/gecco/gc_corrected/$class_vs_reg/gecco.$class_vs_reg\labels.$fold.withgc \
		    --target_layer -2 \
		    --task_index $task \
		    --output_npz_file ism.$class_vs_reg.$fold.$task \
		    --generator_type snp \
		    --interp_method ism_gc \
		    --expand_dims
