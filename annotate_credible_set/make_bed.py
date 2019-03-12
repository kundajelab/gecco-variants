#generate bed files from the 99 percent credible set SNPs to facilited bedtools intersection operations
data=open("99percent_cred_set.tsv",'r').read().strip().split('\n')
outf=open("99percent_cred_set.bed",'w')
outf.write('Chrom\tStart\tEnd\t'+data[0]+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    chrom=tokens[0].split(':')[0]
    endpos=tokens[0].split(':')[1].split('_')[0]
    startpos=str(int(endpos)-1)
    outf.write(chrom+'\t'+startpos+'\t'+endpos+'\t'+line+'\n')
    
