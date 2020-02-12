import pandas as pd
enrichments=open("reshaped.enrichments.txt",'r').read().strip().split('\n')
idmap=pd.read_csv("roadmap_id_map.csv",header=None,sep='\t')
outf=open("annotated.reshaped.enrichments.txt",'w')
idmap_dict=dict()
for index,row in idmap.iterrows():
    idmap_dict[row[0]]=row[1]
print(idmap_dict)
header=enrichments[0]
outf.write(header+'\tcelltype\tgroup'+'\n')
for line in enrichments[1::]:
    tokens=line.split('\t')
    pval=tokens[0]
    tissue=tokens[1]
    value=tokens[2]
    tissue_tokens=tissue.split('.')
    group=tissue_tokens[0]
    if len(tissue_tokens)>1:
        celltype=tissue_tokens[1]
        if celltype in idmap_dict:
            celltype=idmap_dict[celltype]
    else:
        celltype=tissue        
    outf.write('\t'.join([pval,tissue,value,celltype,group])+'\n')
outf.write('\n')
outf.write('\n'.join(enrichments[1::])+'\n')
    
