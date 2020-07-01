for i in `seq 0 9`
do
    python get_alt_allele_fasta.py -fasta $i.gecco.snps.in.dnase.peaks.1kb.fa -out_fasta $i.gecco.snps.in.dnase.peaks.1kb.alt.fa
done
