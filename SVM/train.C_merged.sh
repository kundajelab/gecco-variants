#run 10-fold cross-validation
for i in `seq 0 4`
do
    CUDA_VISIBLE_DEVICES=0 gkmtrain -m 10000 -v 2 -T 16 svm.inputs.C_merged.train.$i.positives svm.inputs.C_merged.train.$i.negatives model.C_merged.$i
    CUDA_VISIBLE_DEVICES=0 gkmpredict -v 2 -T 16 svm.inputs.C_merged.test.$i.positives model.C_merged.$i predictions.C_merged.$i.positives
    CUDA_VISIBLE_DEVICES=0 gkmpredict -v 2 -T 16 svm.inputs.C_merged.test.$i.negatives model.C_merged.$i predictions.C_merged.$i.negatives    
done
