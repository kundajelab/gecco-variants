#!/bin/bash
for fold in 3
do
    outdir=/srv/scratch/annashch/gecco/bpnet/control/bias_corrected_bpnet
    model=bias_corrected_model
    seed=1234
    gpu=1
    title='Bias Corrected CONTROL'
    #./train.sh $fold $gpu $model $seed $outdir
    ./predict.sh $fold $gpu $model $seed $outdir 
    ./score.sh $outdir $model $fold $title 
done
