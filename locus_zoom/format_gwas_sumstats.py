import pandas as pd
data=pd.read_csv("/oak/stanford/groups/akundaje/projects/GECCO/meta_data_locuszoom.txt.gz",header=0,sep='\t')
print(data.head())
print("loaded data")
data['#CHROM']=data['chr']
data['BEGIN']=data['pos']
data['END']=data['pos']+1
data['MARKER_ID']=data['chr'].astype(str)+":"+data['pos'].astype(str)+"_"+data['allele_A'].astype(str)+'/'+data['allele_B'].astype(str)
data['PVALUE']=data['P_value']
data["PVALUE"][data["PVALUE"]==0]=1e-50
data=data[['#CHROM','BEGIN','END','MARKER_ID','PVALUE']]
#write to output
data.to_csv("all.formatted.bed.gz",compression='gzip',header=True,sep='\t',index=False) 

