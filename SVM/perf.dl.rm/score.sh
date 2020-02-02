#dnase_c
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict/$fold.dnase_c.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict/$fold.dnase_c.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.C_merged.$fold \
		  --task_indices 0
done

#dnase_v
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict/$fold.dnase_v.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict/$fold.dnase_v.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.V_merged.$fold \
		  --task_indices 1
done

#sw480
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict/$fold.sw480.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict/$fold.sw480.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.sw480.$fold \
		  --task_indices 2
done

#hct116
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict/$fold.hct116.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict/$fold.hct116.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.hct116.$fold \
		  --task_indices 3
done


#colo205
for fold in `seq 0 9`
do
    kerasAC_score --labels_hdf5 ../dl_predict/$fold.colo205.dl.pred.labels.0 \
		  --predictions_hdf5 ../dl_predict/$fold.colo205.dl.pred.predictions.0 \
		  --performance_metrics_classification_file perf.colo205.$fold \
		  --task_indices 4
done
