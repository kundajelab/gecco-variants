import pandas as pd
from sklearn.metrics import average_precision_score
prefix="/srv/scratch/annashch/gecco/SVM"
import sys
task=sys.argv[1]
fold=sys.argv[2]

labels=pd.read_csv(prefix+"/"+"svm_predictions_svmtrainset_genometestset"+"/"+task+"/"+"labels."+fold+".sorted.bed",header=None,sep='\t')
preds=pd.read_csv(prefix+"/"+"svm_predictions_svmtrainset_genometestset"+"/"+task+"/"+"genomewidepredictions."+task+"."+fold+".sorted.bed",header=None,sep='\t')
merged=pd.concat([labels,preds],axis=1).dropna()[3]
merged.columns=['labels','preds']
cur_auprc=average_precision_score(merged['labels'],merged['preds'])
total=merged.shape[0]
pos=sum(merged['labels'])
neg=total-pos
print(task+'\t'+fold+'\t'+str(cur_auprc)+'\t'+str(pos)+'\t'+str(neg))
