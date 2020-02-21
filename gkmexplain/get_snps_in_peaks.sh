bedtools intersect -a /srv/scratch/annashch/gecco/gwas_summary/variants.with.rsid.bed -b gecco.overlap.bed | bedtools sort -i - | uniq  > gecco.variants.in.overlap.peaks.bed
#split
split -l10 -d -a3 gecco.variants.in.overlap.peaks.bed gecco.variants.in.overlap.peaks
rename 's/gecco.variants.in.overlap.peaks0/gecco.variants.in.overlap.peaks/g' gecco.variants.in.overlap.peaks0*
rename 's/gecco.variants.in.overlap.peaks0/gecco.variants.in.overlap.peaks/g' gecco.variants.in.overlap.peaks0*
