zcat /srv1/scratch/media/gecco/C31_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C34_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C36_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz | bedtools sort -i - | cut -f1,2,3| uniq | bedtools merge -i -  > control.dnase.bed

#unmerged
zcat /srv1/scratch/media/gecco/C31_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C34_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C36_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz | bedtools sort -i - | cut -f1,2,3| uniq   > control.dnase.unmerged.bed
bgzip control.dnase.unmerged.bed
tabix -p bed control.dnase.unmerged.bed.gz

