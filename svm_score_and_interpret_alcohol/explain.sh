#!/bin/bash
split=$1
task=$2
ref_alt=$3
prefix=/oak/stanford/groups/akundaje/projects/GECCO/alcohol
model_prefix=/oak/stanford/groups/akundaje/projects/GECCO/alcohol/models
gkmexplain  $prefix/fasta/alcohol.$split.$ref_alt.fa $model_prefix/model.$task.$split.model.txt $prefix/explain_$ref_alt/gkmexplain.$task.$split.txt


