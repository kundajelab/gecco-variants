for task in dnase_c dnase_v sw480 hct116 colo205
do
    for fold in `seq 0 9`
    do
	
	python make_bed_from_svm.py svm_predictions_svmtrainset_genometestset/$task/genomewidepredictions.$task.$fold.all &
    done
done
