#!/bin/bash
prefix=/srv/scratch/annashch/gecco/gkmexplain/score_summary_and_significance
suffix=gkmexplain.aggregate.txt
for task in dnase_c dnase_v colo205 sw480 hct116
do
    
    python add_gwas_pvalue_to_tsv.py --input_tsv $prefix/$task.$suffix --outf $prefix/$task.with.pval.txt
done

