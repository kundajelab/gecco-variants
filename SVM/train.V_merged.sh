#run 10-fold cross-validation
for i in `seq 0 4`
do
    CUDA_VISIBLE_DEVICES=1 gkmtrain -m 10000 -v 2 -T 16 svm.inputs.V_merged.train.$i.positives svm.inputs.V_merged.train.$i.negatives model.V_merged.$i
    CUDA_VISIBLE_DEVICES=1 gkmpredict -v 2 -T 16 svm.inputs.V_merged.test.$i.positives model.V_merged.$i predictions.V_merged.$i.positives
    CUDA_VISIBLE_DEVICES=1 gkmpredict -v 2 -T 16 svm.inputs.V_merged.test.$i.negatives model.V_merged.$i predictions.V_merged.$i.negatives    
done
