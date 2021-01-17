#zcat /srv1/scratch/media/gecco/C28_H3K4me1.nodup.tagAlign_x_C28_Input.nodup.tagAlign.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C29_H3K4me1.nodup.tagAlign_x_C29_Input.nodup.tagAlign.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C37_H3K4me1.nodup.tagAlign_x_C37_Input.nodup.tagAlign.naive_overlap.narrowPeak.hammock.gz | bedtools sort -i - | bedtools merge -i - > control.h3k4me1.bed

#unmerged
zcat /srv1/scratch/media/gecco/C28_H3K4me1.nodup.tagAlign_x_C28_Input.nodup.tagAlign.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C29_H3K4me1.nodup.tagAlign_x_C29_Input.nodup.tagAlign.naive_overlap.narrowPeak.hammock.gz /srv1/scratch/media/gecco/C37_H3K4me1.nodup.tagAlign_x_C37_Input.nodup.tagAlign.naive_overlap.narrowPeak.hammock.gz | bedtools sort -i - | uniq > control.h3k4me1.unmerged.bed
bgzip control.h3k4me1.unmerged.bed
tabix -p bed control.h3k4me1.unmerged.bed.gz



