import pdb
import numpy as np 
import pandas as pd
data=pd.read_csv("gecco.snps.alcohol.svm.scores.scaled.txt",header=0,sep='\t',index_col=0)
deltas=data[['dnase_c.ALT.REF','dnase_v.ALT.REF','colo205.ALT.REF','hct116.ALT.REF','sw480.ALT.REF']]
maxed=deltas.values[range(deltas.shape[0]),np.nanargmax(deltas**2,axis=1)].tolist() 
maxed=[round(i,3) for i in maxed]
df=pd.DataFrame([deltas.index.tolist(),maxed]).T
df.columns=['SNP','deltaScore']
df.to_csv('gecco.snps.alcohol.svm.scores.scaled.collapsed.txt',sep='\t',header=True,index=False)



