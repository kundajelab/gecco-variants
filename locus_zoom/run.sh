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

    #200kb, EUR 
    #locuszoom  --epacts all.formatted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop EUR --source 1000G_Nov2014 --refsnp $rsid --flank 100kb  --gene-table gencode --plotonly --no-date --prefix EUR.200kb --svg theme=publication   hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE &

    #500kb, EUR
    #locuszoom  --epacts all.formatted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop EUR --source 1000G_Nov2014 --refsnp $rsid --flank 250kb  --gene-table gencode --plotonly --no-date --prefix EUR.500kb --svg theme=publication   hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE &
    
    #1MB, EUR
    #locuszoom  --epacts all.formatted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop EUR --source 1000G_Nov2014 --refsnp $rsid --flank 500kb  --gene-table gencode --plotonly --no-date --prefix EUR.1MB --svg theme=publication hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE &

    #200kb, ASN
    #locuszoom  --epacts all.formatted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop ASN --source 1000G_Nov2014 --refsnp $rsid --flank 100kb  --gene-table gencode --plotonly --no-date --prefix ASN.200KB --svg theme=publication hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE &

    #500kb, ASN
    #locuszoom  --epacts all.formatted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop ASN --source 1000G_Nov2014 --refsnp $rsid --flank 250kb  --gene-table gencode --plotonly --no-date --prefix ASN.500KB --svg theme=publication hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE &

    #1MB, ASN
    locuszoom  --epacts all.formatted.bed.gz --epacts-chr-col \#CHROM  --build hg19 --pop ASN --source 1000G_Nov2014 --refsnp $rsid --flank 500kb  --gene-table gencode --plotonly --no-date --prefix ASN.1MB --svg theme=publication hiStart=$start_flank hiEnd=$end_flank recombOver=TRUE &
done
