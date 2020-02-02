#!/bin/bash
task=$1
gpu=$2
[ -d $task ] || mkdir $task
for fold in 2 #`seq 0 9`
do    
    CUDA_VISIBLE_DEVICES=$gpu kerasAC_train --index_data_path /srv/scratch/annashch/gecco/SVM/dl_inputs/$fold.train.$task.labels.hdf5\
		    --input_data_path seq /srv/scratch/annashch/gecco/SVM/dl_inputs/$fold.train.$task.gc.hdf5\
		    --output_data_path /srv/scratch/annashch/gecco/SVM/dl_inputs/$fold.train.$task.labels.hdf5 \
		    --num_inputs 2 \
		    --num_outputs 1 \
		    --model_prefix $task/$task.$fold.classification.withgc.svmtrainset \
		    --ref_fasta /mnt/data/male.hg19.fa \
		    --batch_size 200 \
		    --architecture_spec functional_basset_classification_gc_corrected \
		    --num_train 100000 \
		    --num_valid 10000 \
		    --num_tasks 1 \
		    --threads 20 \
		    --max_queue_size 100 \
		    --init_weights /srv/scratch/annashch/deeplearning/encode-roadmap.dnase_tf-chip.batch_256.params.npz \
		    --patience 3 \
		    --patience_lr 2 \
		    --expand_dims \
		    --tasks $task gc \
		    --index_tasks $task \
		    --fold $fold \
		    --genome hg19
done
