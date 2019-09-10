import pandas as pd
data=pd.read_csv("all.bed",header=None,sep='\t')
outf=open("all.formatted.bed",'w')
counter=0
for index,row in data.iterrows():
    counter+=1
    if counter%10000==0:
        print(counter) 
    snpinfo=row[0].split(':')
    chrom="chr"+snpinfo[0]
    pos_1based=int(snpinfo[1].split('_')[0])
    pos_0based=pos_1based-1
    pval=row[1]
    snpid=row[0]
    outf.write('\t'.join([str(i) for i in [chrom, pos_0based, pos_1based, snpid, pval]])+'\n')
    
