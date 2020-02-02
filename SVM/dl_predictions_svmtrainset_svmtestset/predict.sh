#!/bin/bash
task=$1
gpu=$2
for split in `seq 0 9`
do
    CUDA_VISIBLE_DEVICES=$gpu kerasAC_predict --index_data_path ../dl_inputs/$split.test.$task.labels.hdf5 \
			--input_data_path seq ../dl_inputs/$split.test.$task.gc.hdf5 \
			--output_data_path ../dl_inputs/$split.test.$task.labels.hdf5 \
			--num_inputs 2 \
			--num_outputs 1 \
			--ref_fasta /users/annashch/male.hg19.fa \
			--load_model_hdf5 /srv/scratch/annashch/gecco/SVM/dl_train/$task/$task.$split.classification.withgc.svmtrainset.hdf5 \
			--threads 20 \
			--max_queue_size 100 \
			--predictions_and_labels_hdf5 $split.$task.dl.pred \
			--genome hg19 \
			--fold $split \
			--batch_size 1000 \
			--expand_dims \
			--tasks $task gc \
			--index_task $task
done
