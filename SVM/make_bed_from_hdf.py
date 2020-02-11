#convert hdf5 label files into bed format 
import sys
fold=sys.argv[1]
import pandas as pd
in_prefix="/srv/scratch/annashch/deeplearning/gecco/gc_corrected/classification"
out_prefix="/srv/scratch/annashch/gecco/SVM/svm_predictions_svmtrainset_genometestset"
data=pd.read_hdf(in_prefix+"/"+"classification.predictions.gc."+fold+".labels.0")
colname_to_task_name={}
colname_to_task_name[0]='dnase_c'
colname_to_task_name[1]='dnase_v'
colname_to_task_name[2]='sw480'
colname_to_task_name[3]='hct116'
colname_to_task_name[4]='colo205'
num_keys=len(colname_to_task_name.keys())
for i in range(num_keys):
    cur_labels=data[i]
    cur_task=colname_to_task_name[i]
    cur_labels.to_csv(out_prefix+"/"+cur_task+"/"+"labels."+str(fold)+".bed",sep='\t',index=True,header=False)
    
