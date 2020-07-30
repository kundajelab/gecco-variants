import pandas as pd
data=pd.read_csv("all.formatted.bed.tmp",header=0,sep='\t')
data['BEGIN']=data['BEGIN']+1
data['END']=data['END']+1
data.to_csv("all.formatted.shifted.bed",sep='\t',index=False,header=True)
