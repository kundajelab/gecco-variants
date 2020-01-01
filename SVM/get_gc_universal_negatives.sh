for i in `seq 5 22` X Y
do
    python /srv/scratch/annashch/bias_correction/genomewide_gc/get_gc_content.py \
	   --input_bed gecco.classificationlabels.SummitWithin200bpCenter.bed.chr$i.gz.universal_negatives \
	   --ref_fasta /mnt/data/male.hg19.fa \
	   --out_prefix universal.negative.gc.seq.chr$i \
	   --store_seq &
done
