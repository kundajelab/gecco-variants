tissue_annotations=/oak/stanford/groups/akundaje/projects/GECCO/ldsc/tissue_specific_snp_annotation
out_dir=/oak/stanford/groups/akundaje/projects/GECCO/ldsc/ldsc_score_regression
mkdir logs 
for chrom in `seq 1 22`
do
    for peak_set in model_peaks roadmap_enhancer_annotations roadmap_peaks scENCODe #htan
    do
	mkdir logs/$peak_set 
	for region in `cat $tissue_annotations/$peak_set`
	do
	    sbatch -J $region.$chrom -o logs/$peak_set.o -e logs/$peak_set.e -p euan,owners,akundaje ldscore_singlecell.sherlock.sh $chrom $tissue_annotations/$peak_set/$region.chr$chrom.annot $out_dir/$peak_set/$region.chr$chrom
	done
    done
done

