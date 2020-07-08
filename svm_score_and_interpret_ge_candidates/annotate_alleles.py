import pandas as pd
annotations=pd.read_csv("annotations.txt",header=None,sep='\t')
snps=pd.read_csv("snps.in.regions.bed",header=None,sep='\t')
annot_dict={}
for index,row in annotations.iterrows():
    annot_dict[row[4]]=row[9].split('/')

    try:
        freqs=[float(i) for i in row[24].strip(',').split(',')]
        if freqs[0]<freqs[1]:
            ref=annot_dict[row[4]][1]
            alt=annot_dict[row[4]][0]
            annot_dict[row[4]]=[ref,alt]
    except:
        print(row[24])
outf=open('snps.in.regions.with.alleles.bed','w')
for index,row in snps.iterrows():
    snp=row[3]
    try:
        alleles=annot_dict[snp]
        title=row[0]+'_'+str(row[1])+'_'+str(row[3])+'_'+str(alleles[0])+'_'+str(alleles[1])
        outf.write(row[0]+'\t'+str(row[1]-1)+'\t'+str(row[2]-1)+'\t'+title+'\t'+alleles[0]+'\t'+alleles[1]+'\n')
    except:
        print(snp) 
outf.close()
