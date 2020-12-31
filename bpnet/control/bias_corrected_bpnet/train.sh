#!/bin/bash

#fold to use for training 
fold=$1

#gpu to use for training 
gpu=$2

#create a title for the model
model_name=$3

#set seed for training
if [ -z "$4" ]
then
    seed=1234
else
    seed=$4
fi
echo "seed:$seed"

#output directory 
if [ -z "$5" ]
then
    outdir='.'
else
    outdir=$5
fi
params=$6
echo "outdir:$outdir"
CUDA_VISIBLE_DEVICES=$gpu kerasAC_train \
		    --seed $seed \
		    --batch_size 100 \
		    --ref_fasta /mnt/data/male.hg19.fa \
		    --tdb_array /srv/scratch/annashch/gecco/tiledb/db \
		    --tdb_partition_attribute_for_upsample overlap_peak \
		    --tdb_partition_thresh_for_upsample 1 \
		    --tdb_input_source_attribute seq \
		    --tdb_input_aggregation None \
		    --tdb_input_transformation None \
		    --tdb_input_flank 673 \
		    --tdb_output_source_attribute count_bigwig_unstranded_5p count_bigwig_unstranded_5p \
		    --tdb_output_flank 500 500 \
		    --tdb_output_aggregation None sum \
		    --tdb_output_transformation None log \
		    --tdb_ambig_attribute ambig_peak \
		    --tdb_input_min None \
		    --tdb_input_max None \
		    --tdb_output_min None None \
		    --tdb_output_max None None \
		    --num_inputs 1 \
		    --num_outputs 2 \
		    --fold $fold \
		    --genome hg19 \
		    --num_train 100000 \
		    --num_valid 10000 \
		    --num_tasks 1 \
		    --upsample_threads 24 \
		    --threads 0 \
		    --max_queue_size 100 \
		    --patience 3 \
		    --patience_lr 2 \
		    --model_prefix $outdir/$model_name.$fold \
		    --architecture_from_file profile_bpnet_dnase_with_bias.py \
		    --model_params $outdir/params.$fold.txt \
		    --tasks CONTROL \
		    --upsample_ratio_list_train 1.0 \
		    --upsample_ratio_list_eval 1.0 \
		    --trackables logcount_predictions_loss loss profile_predictions_loss val_logcount_predictions_loss val_loss val_profile_predictions_loss

