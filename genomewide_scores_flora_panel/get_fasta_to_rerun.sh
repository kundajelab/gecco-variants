prefix=/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores/
for task in colo205 sw480 hct116 dnase_c dnase_v
do
    for fold in `seq 0 9`
    do	
	python get_remaining_fasta.py --last_parsed $prefix/out/last.gkmexplain.$task.$fold.txt --fasta $prefix/fasta/$fold.gecco.snps.in.dnase.peaks.1kb.fa --splits 5 --out $prefix/rerun/$fold.$task.fa
    done
done
