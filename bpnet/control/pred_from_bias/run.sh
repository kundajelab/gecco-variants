#!/bin/bash
for fold in 0 1
do
    gpu=3
    model=pred_from_bias
    seed=1234
    outdir=/srv/scratch/annashch/gecco/bpnet/control/pred_from_bias
    params=params.$fold.txt
    title='CONTROL_PRED_FROM_BIAS' 
    ./train.sh $fold $gpu $model $seed $outdir $params
    #./predict.sh $fold $gpu $model $seed $outdir
    #./score.sh $outdir $model $fold $title
done
