#calcium snps 
python make_fasta.py \
       -ref_fasta /mnt/data/male.hg19.fa \
       -chrom_sizes /mnt/data/annotations/by_release/hg19/hg19.chrom.sizes \
       -snp_file all.snps.calcium.txt \
       -chrom_col Chr \
       -pos1_col Pos1 \
       -name_col RSID \
       -out_prefix calcium \
       -ref_allele_col Ref \
       -alt_allele_col Alt \
       --flank 500 

#diabetes snps 
python make_fasta.py \
       -ref_fasta /mnt/data/male.hg19.fa \
       -chrom_sizes /mnt/data/annotations/by_release/hg19/hg19.chrom.sizes \
       -snp_file all.snps.diabetes.txt \
       -chrom_col Chr \
       -pos1_col Pos1 \
       -name_col RSID \
       -out_prefix diabetes \
       -ref_allele_col Ref \
       -alt_allele_col Alt \
       --flank 500 
