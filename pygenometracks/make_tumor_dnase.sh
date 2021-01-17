#zcat /srv1/scratch/media/gecco/V389_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/V410_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/V576_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz | bedtools sort -i - | bedtools merge -i - > tumor.dnase.bed

#unmerged 
zcat /srv1/scratch/media/gecco/V389_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/V410_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/V576_DNase.trim.nodup.pf.pval0.1.500K.naive_overlap.narrowPeak.hammock.gz | bedtools sort -i - | uniq > tumor.dnase.unmerged.bed
bgzip tumor.dnase.unmerged.bed
tabix -p bed tumor.dnase.unmerged.bed.gz

