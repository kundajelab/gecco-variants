#!/bin/bash
split=$1
task=$2
ref_alt=$3
prefix=/oak/stanford/groups/akundaje/projects/GECCO/svm_score_and_interpret_ge_candidates
model_prefix=/oak/stanford/groups/akundaje/projects/GECCO/SVM/models
gkmexplain  $prefix/fasta/$fold.snps.in.regions.with.alleles.$ref_alt.fa $model_prefix/model.$task.$split.model.txt $prefix/explain_$ref_alt/gkmexplain.$task.$split.txt


