#!/bin/bash
fold=$1
task=$2 
group=$3
prefix=/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores
gkmexplain  $prefix/rerun/$fold.$task.fa.$group $prefix/models/model.$task.$fold.model.txt $prefix/out/gkmexplain.$task.$fold.txt.$group


