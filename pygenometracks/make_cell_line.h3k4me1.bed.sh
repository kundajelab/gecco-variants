#zcat SW480_H3K4me1.nodup.tagAlign_x_SW480_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz HCT116_H3K4me1.nodup.tagAlign_x_HCT116_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz COLO205_H3K4me1.nodup.tagAlign_x_COLO205_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz | bedtools sort -i - | bedtools merge -i - > cell_line.h3k4me1.bed
#bgzip cell_line.h3k4me1.bed
#tabix -p bed cell_line.h3k4me1.bed.gz

#unmerged
zcat SW480_H3K4me1.nodup.tagAlign_x_SW480_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz HCT116_H3K4me1.nodup.tagAlign_x_HCT116_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz COLO205_H3K4me1.nodup.tagAlign_x_COLO205_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz | bedtools sort -i - > cell_line.h3k4me1.unmerged.bed
bgzip cell_line.h3k4me1.unmerged.bed
tabix -p bed cell_line.h3k4me1.unmerged.bed.gz

