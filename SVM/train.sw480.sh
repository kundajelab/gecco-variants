#run 10-fold cross-validation
for i in `seq 0 4`
do
    CUDA_VISIBLE_DEVICES=0 gkmtrain -m 10000 -v 2 -T 16 svm.inputs.sw480.train.$i.positives svm.inputs.sw480.train.$i.negatives model.sw480.$i
    CUDA_VISIBLE_DEVICES=0 gkmpredict -v 2 -T 16 svm.inputs.sw480.test.$i.positives model.sw480.$i predictions.sw480.$i.positives
    CUDA_VISIBLE_DEVICES=0 gkmpredict -v 2 -T 16 svm.inputs.sw480.test.$i.negatives model.sw480.$i predictions.sw480.$i.negatives    
done
