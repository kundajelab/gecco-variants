import pandas as pd
data=pd.read_csv("alcohol.ldwindow.100kb.txt",header=0,sep='\t')
data=data[data['R2']>=0.5]
data.to_csv('alcohol.ldwindow.100kb.r2.gt.0.5.txt',header=True,index=False,sep='\t')

