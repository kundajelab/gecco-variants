#!/bin/bash
for fold in `seq 0 9`
do
    python make_plots.py --ref_gkmexplain_dir /oak/stanford/groups/akundaje/projects/GECCO/alcohol/explain_ref \
	   --alt_gkmexplain_dir /oak/stanford/groups/akundaje/projects/GECCO/alcohol/explain_alt \
	   --out_dir plots \
	   --tasks dnase_c dnase_v sw480 hct116 colo205 \
	   --splits $fold \
	   --rerun rerun.txt &
done
