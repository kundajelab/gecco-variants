python annotate_gwas.py --source_file /srv/scratch/annashch/gecco/annotate_gwas_full_set/gwas_stats/METAANALYSIS_JOINT_CHR21_1_SORTED.tbl \
       --chrom chr22 \
       --flank_for_gc 100 \
       --tss_bed refGene_hg19_TSS.bed \
       --outf annotations.chr22.bed \
       --screen_bed_dir screen_beds

