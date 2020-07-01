for chrom in `seq 2 22`
do
    python annotated_with_rsid.py --bim /mnt/data/ldscore/1000G_plinkfiles/1000G.mac5eur.$chrom.bim --munged /oak/stanford/groups/akundaje/projects/GECCO/ldsc_colorectal_cancer_gwas_summary_statistics/munged.METAANALYSIS_JOINT_CHR$chrom\_1_SORTED.tbl.sumstats.gz --outf /oak/stanford/groups/akundaje/projects/GECCO/ldsc_colorectal_cancer_gwas_summary_statistics/munged.rsid.$chrom.txt &
done
