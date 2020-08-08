for chrom in `seq 1 22`
do
    python make_fasta.py \
	   -ref_fasta /mnt/data/male.hg19.fa \
	   -chrom_sizes /mnt/data/annotations/by_release/hg19/hg19.chrom.sizes \
	   -prefix /oak/stanford/groups/akundaje/projects/GECCO/FloraSNPs_FIGI_full_variant_list/FIGI_full_variant_list_chr \
	   -chrom $chrom \
	   -suffix .txt.gz \
	   -chrom_col Chr \
	   -pos1_col Pos \
	   -name_col id \
	   -out_prefix FloraSNPs \
	   -ref_allele_col REF \
	   -alt_allele_col ALT \
	   --flank 500 &
done
