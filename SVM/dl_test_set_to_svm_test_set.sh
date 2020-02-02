#!/bin/bash

#THIS CODE CONVERTS THE FULL DL TEST SET TO AN SVM TEST SET, THIS ENDS UP BEING TOO BIG, SO WE CONVERT WITH SUBSAMPLING (BELOW) 
#get the peaks 
#python dl_test_set_to_bed_file.py \
#       --hdf5 /srv/scratch/annashch/deeplearning/gecco/gc_corrected/classification/gecco.classificationlabels.SummitWithin200bpCenter.hdf5 \
#       --outf classificationlabels.SummitWithin200bpCenter.bed

#split peaks into test sets
#mkdir genomewide_svminputs
#for fold in `seq 0 9`
#do
#    python get_svm_peak_splits.py --narrowPeak classificationlabels.SummitWithin200bpCenter.bed --nosort --no_train --out_prefix genomewide_svminputs/genomewide_svminputs --genome hg19 --folds $fold &
#done


#python subsample_genomewide_testset_for_svm.py

#extract the fasta file 
for task in dnase_c dnase_v colo205 sw480 hct116
do

    for fold in `seq 0 9`
    do
	bedtools getfasta -fi /mnt/data/male.hg19.fa -bed genomewide_svminputs/$fold.$task.positives > genomewide_svminputs/$fold.$task.positives.fa
	bedtools getfasta -fi /mnt/data/male.hg19.fa -bed genomewide_svminputs/$fold.$task.negatives > genomewide_svminputs/$fold.$task.negatives.fa	
    done
done
