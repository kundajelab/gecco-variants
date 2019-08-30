import pandas as pd
data=pd.read_csv("augmented_gene_enhancer_links.tsv",header=0,sep='\t')
print("loaded data file")
to_exclude=open("ensembl_ids_removed_between_v7_and_v31_of_gencode.txt",'r').read().strip().split('\n')
to_rename=open("ensembl_ids_with_different_gene_names_in_v31_v7.txt",'r').read().strip().split('\n')
data=data[~data['gene_id'].isin(to_exclude)]
print("dropped genes to exclude") 
rename_dict=dict()
for line in to_rename:
    tokens=line.split('\t')
    rename_dict[tokens[0]]=tokens[2]
print("made dictionaries for ensembl ids to rename between v7 and v31")
outf=open("augmented_gene_enhancer_links.filtered.tsv",'w')
header='\t'.join([str(i) for i in data.columns])
outf.write(header+'\n')
for index,row in data.iterrows():
    gene_id=row['gene_id']
    if gene_id in rename_dict:
        row['gene_name']=rename_dict[gene_id]
    outf.write('\t'.join([str(i) for i in row])+'\n')
