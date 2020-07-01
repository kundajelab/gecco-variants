tissue_annotations=/oak/stanford/groups/akundaje/projects/GECCO/ldsc/tissue_specific_snp_annotation
out_dir=/oak/stanford/groups/akundaje/projects/GECCO/ldsc/ldsc_score_regression
#mkdir logs 
for chrom in `seq 4 22`
do
    for peak_set in roadmap_enhancer_annotations  #htan model_peaks scENCODE roadmap_peaks
    do
	#mkdir logs/$peak_set 
	for region in `cat $tissue_annotations/$peak_set.txt`
	do
	    sbatch -J $chrom.$region -o logs/$peak_set/$chrom.$region.o -e logs/$peak_set/$chrom.$region.e -p euan,owners,akundaje ldscore_singlecell.sherlock.sh $chrom $tissue_annotations/$peak_set/$region.chr$chrom.annot $out_dir/$peak_set/$region.chr$chrom
	done
    done
done

