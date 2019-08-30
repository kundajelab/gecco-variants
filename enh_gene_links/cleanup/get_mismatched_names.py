import pandas as pd
v7=open("Union_link_sig_FDR05_Sep_geneid_genename.txt",'r').read().strip().split('\n')
v31=open("gencode.v31.hg19.geneid.tss.txt",'r').read().strip().split('\n')
toremove=open("ensembl_ids_removed_between_v7_and_v31_of_gencode.txt",'r').read().strip().split('\n')
to_exclude=dict()
for line in toremove:
    to_exclude[line]=1
v7_names=dict()
for line in v7:
    tokens=line.split('\t')
    gene_id=tokens[0]
    gene_name=tokens[1]
    v7_names[gene_id]=gene_name
v31_names=dict()
for line in v31:
    tokens=line.split('\t')
    gene_id=tokens[0]
    gene_name=tokens[1]
    v31_names[gene_id]=gene_name 
outf=open("ensembl_ids_with_different_gene_names_in_v31_v7.txt",'w')
outf.write("ENSEMBL_ID\tGencode.v7.gene_name\tGencode.v31.gene_name\n")
for gene_id in v7_names:
    if gene_id in to_exclude:
        continue
    v7_name=v7_names[gene_id]
    print(gene_id+'\t'+str(v7_name))
    v31_name=v31_names[gene_id]
    if v7_name!=v31_name:
        outf.write(gene_id+'\t'+v7_name+'\t'+v31_name+'\n')
