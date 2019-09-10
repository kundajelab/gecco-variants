for cur_file in model_peaks/*gz roadmap_peaks/*gz  roadmap_enhancer_annotations/*bed
do
    echo $cur_file
    cur_file_base=`basename $cur_file`
    bedtools intersect -u -wa -a all.formatted.bed.expanded -b $cur_file >  overlap.$cur_file_base
done
