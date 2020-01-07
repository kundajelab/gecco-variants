for fold in `seq 0 9`
do
    for task in C_merged V_merged sw480 hct116 colo205
    do
	python make_svm_predictions_labels_df.py \
	       --pos_predictions SVM_predictions/predictions.$task.$fold.positives \
	       --neg_predictions SVM_predictions/predictions.$task.$fold.negatives \
	       --out_prefix SVM_predictions_labels_df/$task.$fold
    done
done
