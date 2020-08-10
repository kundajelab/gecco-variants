import pandas as pd 
metadata=pd.read_csv("LD_files.txt",header=None,sep='\t')
for index,row in metadata.iterrows():
    cur_ld=pd.read_csv(row[0],skiprows=1,header=None,sep='\t')
    rsid=row[1]
    print(cur_ld.head())
    refsnp=str(row[2])+":"+str(row[3])+"_"+str(row[4])
    cur_ld['snp2']=rsid
    cur_ld['snp1']=cur_ld[0]
    cur_ld['rsquare']=cur_ld[2]
    cur_ld['dprime']=cur_ld[2]
    tosave=cur_ld[['snp1','snp2','dprime','rsquare']]
    tosave.to_csv(rsid+".ld.1mb.txt",sep='\t',header=True,index=False)
    
