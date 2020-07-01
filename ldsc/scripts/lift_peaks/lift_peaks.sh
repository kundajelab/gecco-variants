#!/bin/bash
module load ucsc_tools
overlap_narrowPeak=$1
intermediate_dir=$2
out_dir=$3


nrow=`cat $overlap_narrowPeak | wc -l`
for i in `seq 1 $nrow`
do
    cur_sample=`head -n$i $overlap_narrowPeak | tail -n1 | cut -f1`
    cur_file=`head -n$i $overlap_narrowPeak | tail -n1 | cut -f2`
    zcat $cur_file | cut -f1,2,3 > $intermediate_dir/$cur_sample.bed
    #liftover the file
    liftOver $intermediate_dir/$cur_sample.bed /mnt/data/annotations/liftOver/hg38/hg38ToHg19.over.chain.gz $out_dir/$cur_sample.lifted.bed $out_dir/$cur_sample.not.lifted.bed 
    echo "Sample: $cur_sample"
    echo "File: $cur_file"
done
