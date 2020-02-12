for task in dnase_c dnase_v sw480 hct116 colo205
do
    for fold in `seq 0 9`
    do
	#rm svm_predictions_svmtrainset_genometestset/$task/genomewidepredictions.$task.$fold.all
	./collapse.sh $task $fold
    done
done
