import pandas as pd
import sys
import pdb 
data=pd.read_csv(sys.argv[1],header=0,sep='\t')
#get all negatives
all_neg=data[data[['dnase_c','dnase_v','sw480','hct116','colo205']].max(axis=1)==0]
all_neg.to_csv(sys.argv[1]+'.universal_negatives',index=False,header=True,sep='\t')

