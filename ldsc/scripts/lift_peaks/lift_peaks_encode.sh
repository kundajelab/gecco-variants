#!/bin/bash
module load ucsc_tools
overlap_narrowPeak='../'



nrow=`cat ../overlap.narrowPeak | wc -l`
for i in `seq 1 $nrow`
do
    cur_sample=`head -n$i overlap.narrowPeak | tail -n1 | cut -f1`
    cur_file=`head -n$i overlap.narrowPeak | tail -n1 | cut -f2`
    zcat $cur_file | cut -f1,2,3 > $cur_sample.bed
    #liftover the file
    liftOver $cur_sample.bed /mnt/data/annotations/liftOver/hg38/hg38ToHg19.over.chain.gz $cur_sample.lifted.bed $cur_sample.not.lifted.bed 
    echo "Sample: $cur_sample"
    echo "File: $cur_file"
done
