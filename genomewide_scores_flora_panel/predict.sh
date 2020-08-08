#!/bin/bash
fasta=$1
model=$2
out=$3
gkmpredict -v 2 -T 16 $fasta $model $out 

