#run 10-fold cross-validation
for i in `seq 0 4`
do
    CUDA_VISIBLE_DEVICES=2 gkmtrain -m 10000 -v 2 -T 16 svm.inputs.colo205.train.$i.positives svm.inputs.colo205.train.$i.negatives model.colo205.$i
    CUDA_VISIBLE_DEVICES=2 gkmpredict -v 2 -T 16 svm.inputs.colo205.test.$i.positives model.colo205.$i predictions.colo205.$i.positives
    CUDA_VISIBLE_DEVICES=2 gkmpredict -v 2 -T 16 svm.inputs.colo205.test.$i.negatives model.colo205.$i predictions.colo205.$i.negatives    
done
