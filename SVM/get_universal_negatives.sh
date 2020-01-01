genomewide_labels --task_list tasks.tsv \
		 --outf gecco.classificationlabels.SummitWithin200bpCenter.bed.gz \
		 --output_type gzip \
		 --chrom_sizes hg19.chrom.sizes \
		 --bin_stride 50 \
		 --left_flank 400 \
		 --right_flank 400 \
		 --bin_size 200 \
		 --task_threads 5 \
		 --chrom_threads 10 \
		 --allow_ambiguous \
		 --labeling_approach peak_summit_in_bin_classification \
		 --store_positives_only \
		 --split_output_by_chrom

