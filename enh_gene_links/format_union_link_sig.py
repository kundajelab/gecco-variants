import pandas as pd
import pdb 
data=pd.read_csv("Union_link_sig_FDR05_Sep.txt",header=0,sep='\t')
data['left_flank']=data['promoter_start']-5000
data['right_flank']=data['promoter_stop']+5000 
subset=data[['promoter_chr','left_flank','right_flank','promoter_start','gene_Ensembl_ID','gene_Ensembl_ID','gene_name','enh_chr','enh_start','enh_stop','significant_EIDUnion_link_sig_FDR05_Sep','distance']]
subset.to_csv("Union_link_sig_FDR05_Sep_reformatted.txt",sep='\t',header=False,index=False)
