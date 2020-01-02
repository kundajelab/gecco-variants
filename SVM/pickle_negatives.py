import pickle
import pandas as pd
import sys
chrom=sys.argv[1]
data=pd.read_csv('universal.negative.gc.seq.chr'+chrom,header=None,sep='\t')
print("loaded:"+'universal.negative.gc.seq.chr'+chrom)
data_dict=dict()
for index,row in data.iterrows():
    if index%1000==0:
        print(index) 
    gc=row[3]
    chrom=row[0]
    start=row[1]
    end=row[2]
    seq=row[4]
    if seq.__contains__("N"):
        continue
    if gc not in data_dict:
        data_dict[gc]=[]
    header='_'.join([str(i) for i in [chrom,start,end,gc]])
    data_dict[gc].append(header+'\n'+seq)
#pickle!
print("pickling chrom:"+str(chrom))
with open('universal.negatives.gc.seq.chr'+str(chrom)+'.pickle','wb') as handle:
    pickle.dump(data_dict,handle)

