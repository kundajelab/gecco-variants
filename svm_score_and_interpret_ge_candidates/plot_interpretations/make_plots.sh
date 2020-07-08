#!/bin/bash
python make_plots.py --ref_gkmexplain_dir /oak/stanford/groups/akundaje/projects/GECCO/svm_score_and_interpret_ge_candidates/explain_ref \
       --alt_gkmexplain_dir /oak/stanford/groups/akundaje/projects/GECCO/svm_score_and_interpret_ge_candidates/explain_alt \
       --out_dir plots \
       --tasks dnase_c dnase_v sw480 hct116 colo205 \
       --splits $1 \
       --rerun rerun.txt
