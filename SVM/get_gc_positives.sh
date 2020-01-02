for split in `seq 0 9`
do
    for task in C_merged V_merged sw480 hct116 colo205
    do
	for dataset in train test
	do
	    python /srv/scratch/annashch/bias_correction/genomewide_gc/get_gc_content.py \
		   --input_bed svm.peaks.$task.$dataset.$split \
		   --ref_fasta /mnt/data/male.hg19.fa \
		   --out_prefix svm.peaks.$task.$dataset.$split.gc.seq \
		   --center_summit \
		   --flank_size 500 \
		   --store_seq
	done
    done
done
