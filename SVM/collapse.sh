#!/bin/bash
prefix=/oak/stanford/groups/akundaje/projects/GECCO/SVM
task=$1
fold=$2
for i in `seq 0 150`
do
    cat $prefix/$task/predictions_genomewide/genomewide_predictions.$task.$fold.$i  >> svm_predictions_svmtrainset_genometestset/$task/genomewidepredictions.$task.$fold.all
    echo $i
done
