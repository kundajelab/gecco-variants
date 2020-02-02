#dnase_c
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict_small_model/$fold.dnase_c.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict_small_model/$fold.dnase_c.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.C_merged.$fold \
		  --task_indices 0
done

#dnase_v
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict_small_model/$fold.dnase_v.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict_small_model/$fold.dnase_v.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.V_merged.$fold \
		  --task_indices 0
done

#sw480
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict_small_model/$fold.sw480.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict_small_model/$fold.sw480.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.sw480.$fold \
		  --task_indices 0
done

#hct116
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict_small_model/$fold.hct116.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict_small_model/$fold.hct116.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.hct116.$fold \
		  --task_indices 0
done


#colo205
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict_small_model/$fold.colo205.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict_small_model/$fold.colo205.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.colo205.$fold \
		  --task_indices 0
done
