#run 10-fold cross-validation
for i in `seq 0 4`
do
    CUDA_VISIBLE_DEVICES=3 gkmtrain -m 10000 -v 4 -T 16 svm.inputs.hct116.train.$i.positives svm.inputs.hct116.train.$i.negatives model.hct116.$i
    CUDA_VISIBLE_DEVICES=3 gkmpredict -v 4 -T 16 svm.inputs.hct116.test.$i.positives model.hct116.$i predictions.hct116.$i.positives
    CUDA_VISIBLE_DEVICES=3 gkmpredict -v 4 -T 16 svm.inputs.hct116.test.$i.negatives model.hct116.$i predictions.hct116.$i.negatives    
done
