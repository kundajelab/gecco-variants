import sys
task=sys.argv[1] 
fold=sys.argv[2]
out_prefix="/srv/scratch/annashch/gecco/SVM/svm_predictions_svmtrainset_genometestset"
data=open(out_prefix+"/"+task+"/"+"labels."+fold+".bed",'r').read().strip().split('\n')
outf=open(out_prefix+"/"+task+"/"+"labels."+fold+'.filled.bed','w')
for line in data:
    tokens=line.split('\t')
    if tokens[-1]!="":
        outf.write(line+'\n')
    else:
        outf.write(line+'NA\n')
outf.close()
