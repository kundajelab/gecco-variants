#!/bin/bash 
module load java 
/home/users/annashch/trim_rna_trimmomatic.sh --R1 $1 \
    --R2 $2 \
    --output $3 \
    --readLength 50 \
    --ncpus 10
/home/users/annashch/trim_rna_trimmomatic.sh --R1 $4 \
    --R2 $5 \
    --output $6 \
    --readLength 50 \
    --ncpus 10
