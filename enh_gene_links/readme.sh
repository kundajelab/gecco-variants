#download gencode 31 (GRCH37) annotations 
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/GRCh37_mapping/gencode.v31lift37.annotation.gtf.gz

#get regions +/-5 kb within Gencode TSS
#output:
#chr start end ensgid tss_pos gene_id_full gene_id gene_name 
python get_tss_from_gencode.py --outf gencode.v31.hg19.tss.bed --flank 5000 --gtf gencode.v31lift37.annotation.gtf.gz --short_flank 100 
all_tss=gencode.v31.hg19.tss.bed
short_tss=gencode.v31.hg19.tss.bed.short

#intersect with Scacheri Batch 1 H3K27ac narrowPeak (merged_C, merged_V, COLO205, HCT116, SW480)

#find genes that are expressed in HCT116 (i.e. tss+/-100 bp intersects a peak )
datasets=( H3K27ac.HCT116 H3K27ac.SW480 H3K27ac.COLO205 H3K27ac.MergedC H3K27ac.MergedV )
peaksets=( /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/H3K27ac/HCT116_H3K27ac_rep1-pr.naive_overlap.narrowPeak.gz optimal_overlap/H3K27ac/SW480_H3K27ac.nodup.tagAlign_x_SW480_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/H3K27ac/COLO205_H3K27ac.nodup.tagAlign_x_COLO205_Input.nodup.tagAlign.naive_overlap.narrowPeak.gz /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/merged/H3K27ac_C_merge_bam_rep1-pr.naive_overlap.narrowPeak.gz /srv/scratch/annashch/gecco/enh_gene_links/optimal_overlap/merged/H3K27ac_V_merge_bam_rep1-pr.naive_overlap.narrowPeak.gz )


for i in `seq 0 4`
do
    cur_dataset="${datasets[i]}"
    cur_peakset="${peaksets[i]}"
    echo $cur_dataset
    echo $cur_peakset
    #get expressed tss
    bedtools intersect -u -a $short_tss -b $cur_peakset  > $short_tss.$cur_dataset
    #filter tss to only those expressed
    python extract_tss_subset.py --subset $short_tss.$cur_dataset --source $all_tss --outf tmp.$cur_dataset
    #get enhancers within +/-5kb of tss
    bedtools intersect -wo -b $cur_peakset -a tmp.$cur_dataset | cut -f1-10 > gencode.v31.hg19.tss.5kbflank.intersection.$cur_dataset.bed
    rm $short_tss.$cur_dataset
    rm tmp.$cur_dataset     
done

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
    #get enhancers at p<e-10
    wget -O reg2map_p10/p10_regions_enh_$celltype.bed.gz https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p10/enh/BED_files_per_sample/regions_enh_$celltype.bed.gz
    #get promoters at p<e-10
    wget -O reg2map_p10/p10_regions_prom_$celltype.bed.gz https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p10/prom/BED_files_per_sample/regions_prom_$celltype.bed.gz
    #get expressed tss
    echo $celltype
    echo $short_tss

    bedtools intersect -u -a $short_tss -b reg2map_p10/p10_regions_prom_$celltype.bed.gz > $short_tss.$celltype.p10
    python extract_tss_subset.py --subset $short_tss.$celltype.p10 --source $all_tss --outf tmp.$celltype.p10
    bedtools intersect -wo -b reg2map_p10/p10_regions_enh_$celltype.bed.gz -a tmp.$celltype.p10 | cut -f1-10  > gencode.v31.hg19.tss.5kbflank.intersection.honeybadger2.p10.$celltype.bed
    rm tmp.$celltype.p10
    rm $short_tss.$celltype.p10 


    #get enhancers at p<e-2
    wget -O reg2map_p2/p2_regions_enh_$celltype.bed.gz https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p2/enh/BED_files_per_sample/regions_enh_$celltype.bed.gz
    #get promoters at p<e-2
    wget -O reg2map_p2/p2_regions_prom_$celltype.bed.gz https://personal.broadinstitute.org/meuleman/reg2map/HoneyBadger2_release/DNase/p2/prom/BED_files_per_sample/regions_prom_$celltype.bed.gz
    #get expressed tss
    bedtools intersect -u -a $short_tss -b reg2map_p2/p2_regions_prom_$celltype.bed.gz > $short_tss.$celltype.p2
    python extract_tss_subset.py --subset $short_tss.$celltype.p2 --source $all_tss --outf tmp.$celltype.p2
    bedtools intersect -wo -b reg2map_p2/p2_regions_enh_$celltype.bed.gz -a tmp.$celltype.p2 | cut -f1-10  > gencode.v31.hg19.tss.5kbflank.intersection.honeybadger2.p2.$celltype.bed
    rm tmp.$celltype.p2
    rm $short_tss.$celltype.p2 

done

#aggregate the enhancer overlaps
./aggregate.sh


#add in the Union_link file:
wget https://personal.broadinstitute.org/anshul/projects/roadmap/integrative/enh_gene_links/Union_link_sig_FDR05_Sep.txt.gz
python format_union_link_sig.py
cat header Union_link_sig_FDR05_Sep_reformatted.txt augmented_enhancers_5kb_tss.bed > augmented_gene_enhancer_links.tsv


