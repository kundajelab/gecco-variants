import pandas as pd
tss=pd.read_csv("gencode.v31.hg19.tss.bed",header=None,sep='\t')
gene_id_to_enh=dict()
for index,row in tss.iterrows():
    gene_id=row[5]
    #print(gene_id)
    gene_id_to_enh[gene_id]=dict()
print("made dict") 
data=pd.read_csv("augmented_gene_enhancer_links.tsv",header=0,sep='\t')
print("loaded augmented")
n=data.shape
print(n)
sources=set()
for index,row in data.iterrows():
    if index%1000==0:
        print(index)
    cur_gene=row['gene_id']
    if cur_gene not in gene_id_to_enh:
        print(cur_gene)
        continue 
    source=row['annotation_source']
    source=source.split(';')[-1]
    sources.add(source) 
    if source not in gene_id_to_enh[cur_gene]:
        gene_id_to_enh[cur_gene][source]=1
    else:
        gene_id_to_enh[cur_gene][source]+=1
sources=list(sources)
print("writing") 
outf=open("enh_per_gene_by_source.txt",'w')
outf.write('gene\tsource\tcount\n')
for gene in gene_id_to_enh:
    for source in sources:
        if source in gene_id_to_enh[gene]:
            outf.write(gene+'\t'+source+'\t'+str(gene_id_to_enh[gene][source])+'\n')
        else:
            outf.write(gene+'\t'+source+'\t'+str(0)+'\n')
    
