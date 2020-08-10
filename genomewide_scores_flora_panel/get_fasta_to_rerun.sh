prefix=/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores_flora/
for task in colo205 sw480 hct116 dnase_c dnase_v
do
    for fold in `seq 0 9`
    do	
	for group in ref alt 
	do
	    python get_remaining_fasta.py --last_parsed $prefix/pred_$group/last.$group.pred.$fold.$task.txt --fasta $prefix/fasta/FloraSNPs.$fold.$group.fa --splits 1 --out $prefix/rerun/FloraSNPs.$fold.$group.fa
	done
    done
done
