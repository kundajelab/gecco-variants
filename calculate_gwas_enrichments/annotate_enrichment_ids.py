import pandas as pd
#enrichments=pd.read_csv("gecco.gwas.enrichments.peaks.overlap.bed",header=0,sep='\t')
enrichments=pd.read_csv("gecco.gwas.enrichments.enhancer_annotations.overlap.bed",header=0,sep='\t')
idmap=pd.read_csv("roadmap_id_map.csv",header=None,sep='\t')
#outf=open("annotated.gecco.gwas.enrichments.peaks.overlap.bed",'w')
outf=open("annotated.gecco.gwas.enrichments.enhancer_annotations.overlap.bed",'w')
idmap_dict=dict()
for index,row in idmap.iterrows():
    idmap_dict[row[0]]=row[1]
print(idmap_dict) 
for index,row in enrichments.iterrows():
    cur_id=row['Cluster'] 
    if cur_id in idmap_dict:
        groupname=idmap_dict[cur_id]
    else:
        groupname=cur_id
    out_string='\t'.join([str(i) for i in row])+'\t'+str(groupname)+'\n'
    outf.write(out_string)
    
