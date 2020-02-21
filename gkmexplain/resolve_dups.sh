#!/bin/bash
prefix=/oak/stanford/groups/akundaje/projects/GECCO/SVM/gkmexplain_scores/aggregate/
for f in $prefix/*colo*txt
do
    python resolve_dups.py $f &
    #echo $f
done
