for task in dnase_c dnase_v colo205 hct116 sw480
do
    for fold in `seq 0 9`
    do
	sort -k1,1V -k2,2 svm_predictions_svmtrainset_genometestset/$task/genomewidepredictions.$task.$fold.sorted.bed > svm_predictions_svmtrainset_genometestset/$task/tmp
	mv  svm_predictions_svmtrainset_genometestset/$task/tmp svm_predictions_svmtrainset_genometestset/$task/genomewidepredictions.$task.$fold.sorted.bed
	sort -k1,1V -k2,2 svm_predictions_svmtrainset_genometestset/$task/labels.$fold.sorted.bed > svm_predictions_svmtrainset_genometestset/$task/tmp
	mv svm_predictions_svmtrainset_genometestset/$task/tmp svm_predictions_svmtrainset_genometestset/$task/labels.$fold.sorted.bed
	echo "$task , $fold"
    done
done
