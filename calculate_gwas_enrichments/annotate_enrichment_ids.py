import pandas as pd
enrichments=open("reshaped.enrichments.tsv",'r').read().strip().split('\n')
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
    if tissue.startswith('Enh'):
        group='Enh'
    elif tissue.startswith('E'):
        group="200k"
    else:
        group="Scacheri"
    if len(tissue_tokens)>1:
        celltype=tissue_tokens[1]
    else:
        celltype=tissue_tokens[0]
    if celltype in idmap_dict:
        celltype=idmap_dict[celltype]
    print(celltype+","+group)
    outf.write('\t'.join([pval,tissue,value,celltype,group])+'\n')
outf.write('\n')
outf.close()

#outf.write('\n'.join(enrichments[1::])+'\n')
    
