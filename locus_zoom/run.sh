number=`cat snp_short_list.txt| wc -l`
highlight_flank=500
for i in `seq 1 $number`
do
    rsid=`cut -f1 snp_short_list.txt | head -n$i | tail -n1`
    chrom=`cut -f2 snp_short_list.txt | head -n$i | tail -n1`
    pos=`cut -f3 snp_short_list.txt | head -n$i | tail -n1`
    alleles=`cut -f4 snp_short_list.txt | head -n$i | tail -n1`
    start_flank="$(($pos-$highlight_flank))"
    end_flank="$(($pos+$highlight_flank))"
    leadsnp=$chrom:$pos\_$alleles
    echo $leadsnp
    locuszoom  --epacts all.formatted.shifted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop EUR --source 1000G_Nov2014 --refsnp $leadsnp --flank 100kb --gwas-cat whole-cat_significant-only --gene-table gencode --plotonly --no-date --prefix EUR --svg theme=publication signifLine=8  title="$rsid:$leadsnp" hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE
    locuszoom  --epacts all.formatted.shifted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop EAS --source 1000G_Nov2014 --refsnp $leadsnp --flank 100kb --gwas-cat whole-cat_significant-only --gene-table gencode --plotonly --no-date --prefix EAS --svg theme=publication signifLine=8  title="$rsid:$leadsnp" hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE
done





