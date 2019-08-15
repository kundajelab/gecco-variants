import pandas as pd
data=pd.read_table("rs1800734_3_37034946_100kb.txt",header=0,sep='\t')
outf=open('rs1800734_3_37034946_100kb.collapsed.txt','w')
outf.write('\t'.join([str(i) for i in data.columns])+'\n')
label_dict=dict() 
for index,row in data.iterrows():
    key=tuple(row[0:6])
    vals=row[6::]
    if key not in  label_dict:
        label_dict[key]=vals
    else:
        for i in range(len(vals)):
            old_val=label_dict[key][i]
            new_val=vals[i]
            if str(old_val)=="nan":
                continue
            if str(old_val)=="0":
                label_dict[key][i]=new_val
for key in label_dict:
    outf.write('\t'.join([str(i) for i in key])+'\t'+'\t'.join([str(i) for i in label_dict[key]])+'\n')
    
    
