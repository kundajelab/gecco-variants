import pandas as pd
from os import listdir
from os.path import isfile, join
import pdb 
mypath="/srv1/scratch/gecco_pygenometracks/intersections_peak_snp"
files = [f for f in listdir(mypath) if isfile(join(mypath, f))]
print(files)
first=True
for f in files:
    if f.endswith("intersection.snp.bed"):
        print(f)
        data=pd.read_csv(f,sep='\t',header=None)
        dataset=f.split('.')[0] 
        #get the summit distance
        data['summit_pos']=data[1]+data[9] 
        data['summit_dist']=data['summit_pos']-data[11]
        data['peak_score']=data[6]
        data['dataset_name']=dataset
        subset=data[[10,11,12,13,'summit_dist','peak_score','dataset_name']]
        subset.colnames=['chrom','pos0','pos1','snp','summit_dist','peak_score','dataset']
        if first==True: 
            subset.to_csv('SNP_scores.csv', mode='w', header=True,index=False)
        else:
            subset.to_csv('SNP_scores.csv', mode='a', header=False,index=False)
        first=False
