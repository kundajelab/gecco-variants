#download gencode 31 (GRCH37) annotations 
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/GRCh37_mapping/gencode.v31lift37.annotation.gtf.gz

#get regions +/-5 kb within Gencode TSS
#output:
#chr start end ensgid tss_pos gene_id_full gene_id gene_name 
python get_tss_from_gencode.py --outf gencode.v31.hg19.tss.bed --flank 5000 --gtf gencode.v31lift37.annotation.gtf.gz

#intersect with Scacheri Batch 1 H3K27ac narrowPeak (merged_C, merged_V, COLO205, HCT116, SW480)
bedtools intersect -wo -b /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/H3K27ac/HCT116_H3K27ac_rep1-pr.naive_overlap.narrowPeak.gz -a gencode.v31.hg19.tss.bed | cut -f1-10 > gencode.v31.hg19.tss.5kbflank.intersection.H3K27ac.HCT116.bed

bedtools intersect -wo -b /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/H3K27ac/SW480_H3K27ac.nodup.tagAlign_x_SW480_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz -a gencode.v31.hg19.tss.bed | cut -f1-10 > gencode.v31.hg19.tss.5kbflank.intersection.H3K27ac.SW480.bed

bedtools intersect -wo -b /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/H3K27ac/COLO205_H3K27ac.nodup.tagAlign_x_COLO205_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz -a gencode.v31.hg19.tss.bed | cut -f1-10 > gencode.v31.hg19.tss.5kbflank.intersection.H3K27ac.COLO205.bed

bedtools intersect -wo -b /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/merged/H3K27ac_C_merge_bam_rep1-pr.naive_overlap.narrowPeak.gz -a gencode.v31.hg19.tss.bed | cut -f1-10 > gencode.v31.hg19.tss.5kbflank.intersection.H3K27ac.MergedC.bed

bedtools intersect -wo -b /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/merged/H3K27ac_V_merge_bam_rep1-pr.naive_overlap.narrowPeak.gz -a gencode.v31.hg19.tss.bed| cut -f1-10 > gencode.v31.hg19.tss.5kbflank.intersection.H3K27ac.MergedV.bed

#intersect w/ reg2map honeybadger2 
#Cell types of interest (from Yu-Ru)
#Digestive: "E075", "E077", "E079", "E084", "E085", "E092", "E094", "E101", "E102", "E106", "E109", "E110"
#Immune: "E030", "E031", "E032", "E034", "E044"
#p2 (less stringent)
#https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p2/enh/BED_files_per_sample/

#p10 (more stringent) 
#https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p10/enh/BED_files_per_sample/
for celltype in E030 E031 E032 E034 E044 E075 E077 E079 E084 E085 E092 E094 E101 E102 E106 E109 E110
do
    wget -O reg2map_p10/p10_regions_enh_$celltype.bed.gz https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p10/enh/BED_files_per_sample/regions_enh_$celltype.bed.gz
    bedtools intersect -wo -b reg2map_p10/p10_regions_enh_$celltype.bed.gz -a gencode.v31.hg19.tss.bed | cut -f1-10  > gencode.v31.hg19.tss.5kbflank.intersection.honeybadger2.p2.$celltype.bed
    wget -O reg2map_p2/p2_regions_enh_$celltype.bed.gz https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p2/enh/BED_files_per_sample/regions_enh_$celltype.bed.gz
    bedtools intersect -wo -b reg2map_p2/p2_regions_enh_$celltype.bed.gz -a gencode.v31.hg19.tss.bed | cut -f1-10 > gencode.v31.hg19.tss.5kbflank.intersection.honeybadger2.p10.$celltype.bed
done

#aggregate the enhancer overlaps
./aggregate.sh
python format_union_link_sig.py
cat header Union_link_sig_FDR05_Sep_reformatted.txt augmented_enhancers_5kb_tss.bed > augmented_gene_enhancer_links.tsv


