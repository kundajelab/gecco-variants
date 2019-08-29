import pandas as pd
import pdb 
data=pd.read_csv("Union_link_sig_FDR05_Sep.txt",header=0,sep='\t')
data['left_flank']=data['promoter_stop']-5000
data['right_flank']=data['promoter_stop']+5000
#subset to the relevant tissue types

#EID_digestiveTissue = c("E075", "E077", "E079", "E084", "E085", "E092", "E094", "E101", "E102", "E106", "E109", "E110")
#EID_immuneTissue = c("E030", "E031", "E032", "E034", "E044")
tissues_to_keep=set(["E075", "E077", "E079", "E084", "E085", "E092", "E094", "E101", "E102", "E106", "E109", "E110","E030", "E031", "E032", "E034", "E044"])

subset=data[['promoter_chr','left_flank','right_flank','promoter_start','gene_Ensembl_ID','gene_Ensembl_ID','gene_name','enh_chr','enh_start','enh_stop','significant_EID','distance']]
header='\t'.join([i for i in subset.columns])
outf=open("Union_link_sig_FDR05_Sep_reformatted.txt",'w')
#outf.write(header+'\n')
for index,row in subset.iterrows():
    sig_cell_types=set([i.split('_')[0] for i in row["significant_EID"].split(';')])
    sig_cell_types_intersection=sig_cell_types.intersection(tissues_to_keep)
    if len(sig_cell_types_intersection)>0:
        row['significant_EID']=row['significant_EID']+';Union_link_sig_FDR05_Sep'
        outf.write('\t'.join([str(i) for i in row])+'\n')
        
    
    
    
