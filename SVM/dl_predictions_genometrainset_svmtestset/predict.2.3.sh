for split in 2 3
do
    for task in dnase_c dnase_v sw480 hct116 colo205
    do
	CUDA_VISIBLE_DEVICES=1 kerasAC_predict --index_data_path ../dl_inputs/$split.test.$task.labels.hdf5 \
			    --input_data_path seq ../dl_inputs/$split.test.$task.gc.hdf5 \
			    --output_data_path ../dl_inputs/$split.test.$task.labels.hdf5 \
			    --num_inputs 2 \
			    --num_outputs 1 \
			    --ref_fasta /users/annashch/male.hg19.fa \
			    --load_model_hdf5 /srv/scratch/annashch/deeplearning/gecco/classification/gecco.classificationlabels.$split.withgc \
			    --batch_size 1000 \
			    --threads 20 \
			    --max_queue_size 100 \
			    --predictions_and_labels_hdf5 $split.$task.dl.pred \
			    --genome hg19 \
			    --fold $split \
			    --expand_dims
    done
done
