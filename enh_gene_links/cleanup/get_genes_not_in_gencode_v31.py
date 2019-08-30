import pandas as pd
v7=pd.read_csv("Union_link_sig_FDR05_Sep_geneid_genename.txt", header=None,sep='\t')
v31=pd.read_csv("gencode.v31.hg19.geneid.tss.txt", header=None,sep='\t')
v7_geneid=set(v7[0])
v31_geneid=set(v31[0])
removed=v7_geneid-v31_geneid
outf=open("ensembl_ids_removed_between_v7_and_v31_of_gencode.txt",'w')
outf.write('\n'.join(list(removed))+'\n')
