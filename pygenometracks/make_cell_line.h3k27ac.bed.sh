#zcat SW480_H3K27ac.nodup.tagAlign_x_SW480_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz HCT116_H3K27ac_rep1-pr.naive_overlap.filt.narrowPeak.gz COLO205_H3K27ac.nodup.tagAlign_x_COLO205_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz | bedtools sort -i - | bedtools merge -i - > cell_line.h3k27ac.bed
#bgzip cell_line.h3k27ac.bed
#tabix -p bed cell_line.h3k27ac.bed.gz

#unmerged
zcat SW480_H3K27ac.nodup.tagAlign_x_SW480_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz HCT116_H3K27ac_rep1-pr.naive_overlap.filt.narrowPeak.gz COLO205_H3K27ac.nodup.tagAlign_x_COLO205_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz | bedtools sort -i - |uniq > cell_line.h3k27ac.unmerged.bed
bgzip cell_line.h3k27ac.unmerged.bed
tabix -p bed cell_line.h3k27ac.unmerged.bed.gz
