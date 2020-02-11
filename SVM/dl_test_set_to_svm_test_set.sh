#!/bin/bash


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

#extract the fasta file
for fold in `seq 0 9`
do
    #bedtools getfasta -fi /mnt/data/male.hg19.fa -bed genomewide_svminputs/genomewide_svminputs.test.$fold  > genomewide_svminputs/genomewide_svminputs.test.$fold.fasta &
    split -l 100000 -d -a3 genomewide_svminputs/genomewide_svminputs.test.$fold.fasta genomewide_svminputs/genomewide_svm_inputs.test.$fold.fasta. 
    echo $fold
done
