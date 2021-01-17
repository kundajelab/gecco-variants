#zcat sw480_ppr.naive_overlap.filt.narrowPeak.gz hct116_rep1-rep2.naive_overlap.filt.narrowPeak.gz colo205_rep1-pr.naive_overlap.filt.narrowPeak.gz | bedtools sort -i - | cut -f1,2,3| uniq | bedtools merge -i -  > cell_line.dnase.bed
#bgzip cell_line.dnase.bed
#tabix -p bed cell_line.dnase.bed.gz

#no merge
zcat sw480_ppr.naive_overlap.filt.narrowPeak.gz hct116_rep1-rep2.naive_overlap.filt.narrowPeak.gz colo205_rep1-pr.naive_overlap.filt.narrowPeak.gz | bedtools sort -i - | cut -f1,2,3| uniq  > cell_line.dnase.unmerged.bed
bgzip cell_line.dnase.unmerged.bed
tabix -p bed cell_line.dnase.unmerged.bed.gz

