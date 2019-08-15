import pandas as pd
rsid_data=pd.read_csv("variants.with.rsid.bed",header=0,sep='\t')
chrom_data=pd.read_csv("chrom13.for.locuszoom.bed",header=0,sep='\t')
rsid_dict=dict() 
for index,row in rsid_data.iterrows():
    chrom=row['Chrom']
    pos=row['StartPos']
    rsid=row['Rsid']
    ref=row['Ref']
    alt=row['Alt']
    label=chrom.replace('chr','')+':'+str(pos)+'_'+str(ref)+'/'+str(alt)
    rsid_dict[label]=rsid
print("made dict") 
outf=open('plink_formatted.txt','w')
outf.write("#CHROM\tPOS\tID\tREF\tALT\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\n")
for index,row in chrom_data.iterrows():
    cur_id=row['ID']
    if cur_id in rsid_dict:
        rs=rsid_dict[cur_id]
        outf.write(rs+'\t'+'\t'.join([str(i) for i in row])+'\n')

