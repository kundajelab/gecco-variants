#!/bin/bash
task=$1
gkmexplain_prefix=/oak/stanford/groups/akundaje/projects/GECCO/SVM/gkmexplain_scores/aggregate_nodups
prediction_prefix=/oak/stanford/groups/akundaje/projects/GECCO/SVM/$task/predictions_snps
python get_score_summary_and_significance.py --ref_fold_scores $gkmexplain_prefix/scores.ref.$task.* \
       --alt_fold_scores $gkmexplain_prefix/scores.alt.$task.* \
       --start_base_snp_score 475 \
       --end_base_snp_score 525 \
       --outf $task.gkmexplain.aggregate.txt \
       --ref_seqs /oak/stanford/groups/akundaje/projects/GECCO/SVM/variant_seqs/ref.all.fa \
       --alt_seqs /oak/stanford/groups/akundaje/projects/GECCO/SVM/variant_seqs/alt.all.fa

       
