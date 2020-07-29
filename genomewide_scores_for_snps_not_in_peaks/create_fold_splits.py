import pandas as pd
from kerasAC.splits import *
import pdb 
#load the bed file
data=pd.read_csv("gecco.snps.not.in.dnase.peaks.bed",header=None,sep='\t')
print("loaded bed file")
for split in hg19_splits:
    cur_test_chroms=hg19_splits[split]['test']
    cur_split_df=data[data[0].isin(cur_test_chroms)]
    cur_split_df.to_csv(str(split)+".gecco.snps.not.in.dnase.peaks.bed",header=False, index=False,sep='\t')
    
