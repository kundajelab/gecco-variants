#!/bin/bash
task=$1
gpu=$2
prefix=/srv/scratch/annashch/gecco/SVM
[ -d $prefix/dl_predictions_svmtrainset_genometestset/$task ] || mkdir -p $prefix/dl_predictions_svmtrainset_genometestset/$task
#for task in colo205 dnase_c dnase_v hct116 sw480
#do
for fold in `seq 0 9`
do
    
    CUDA_VISIBLE_DEVICES=$gpu kerasAC_predict --index_data_path /srv/scratch/annashch/deeplearning/gecco/gc_corrected/classification/gecco.classificationlabels.SummitWithin200bpCenter.hdf5 \
			--input_data_path seq /srv/scratch/annashch/deeplearning/gc_experiments/gecco/gc_hg19_110bp.hdf5 \
			--output_data_path /srv/scratch/annashch/deeplearning/gecco/gc_corrected/classification/gecco.classificationlabels.SummitWithin200bpCenter.hdf5 \
			--num_inputs 2 \
			--num_outputs 1 \
			--ref_fasta /mnt/data/male.hg19.fa \
			--load_model_hdf5 dl_model_svmtrainset/$task/$task.$fold.classification.withgc.svmtrainset.hdf5 \
			--threads 20 \
			--max_queue_size 100 \
			--predictions_and_labels_hdf5 $prefix/dl_predictions_svmtrainset_genometestset/$task.$fold.classification.withgc.dl.pred.svmtrainset.svmtestset.hdf5 \
			--genome hg19 \
			--fold $fold \
			--batch_size 200 \
			--expand_dims \
			--tasks $task gc_110bp \
			--index_task $task
done
