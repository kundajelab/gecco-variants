import pandas as pd
import pdb
raw_scores=pd.read_csv("gecco.snps.in.gxe.short.list.svm.scores.annotated.txt",header=0,sep='\t') 
mean_and_stdev=pd.read_csv("mean_and_std.tsv",header=0,sep='\t',index_col=0)
columns=mean_and_stdev.columns.tolist()
#pdb.set_trace() 
for column in columns:
    raw_scores[column]=(raw_scores[column]-mean_and_stdev[column].loc['means'])/mean_and_stdev[column]['std']
raw_scores.to_csv('gecco.snps.in.gxe.short.list.svm.adjusted.txt',index=True,header=True,sep='\t')

