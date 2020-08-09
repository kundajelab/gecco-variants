import pandas as pd
prefix="/oak/stanford/groups/akundaje/projects/GECCO/Asian-UK-US-GWAS-meta-analysis/US_UK_ASN_CRC_meta_info4_"
suffix=".txt.gz"
merged_df=None 
for chrom in range(1,23):
    data=pd.read_csv(''.join([prefix,str(chrom),suffix]),header=0,sep=' ')
    print("loaded data for chrom:"+str(chrom))
    data['#CHROM']=data['chr']
    data['BEGIN']=data['pos']
    data['END']=data['pos']+1
    data['MARKER_ID']=data['chr'].astype(str)+"_"+data['pos'].astype(str)+"_"+data['allele_A'].astype(str)+'/'+data['allele_B'].astype(str)
    data['PVALUE']=data['P_value']
    data=data[['#CHROM','BEGIN','END','MARKER_ID','PVALUE']]
    if merged_df is None:
        merged_df=data
    else:
        merged_df=pd.concat([merged_df,data],axis=0)
#write to output
merged_df.to_csv("all.formatted.bed.new.gz",compression='gzip',header=True,sep='\t',index=False) 
