import sys 
data=open(sys.argv[1],'r').read().strip().split('\n')
outf=open(sys.argv[2],'w')
for line in data:
    tokens=line
    try:
        pos=tokens.split('_')[0]
        alleles=tokens.split('_')[1]
        chrom='chr'+pos.split(':')[0]
        base=pos.split(":")[1]
        ref_allele=alleles.split('/')[0]
        alt_allele=alleles.split('/')[1]
        print(chrom+'\t'+base+'\t'+str(int(base)+1)+'\t'+ref_allele+'\t'+alt_allele+'\t'+line+'\n')
        outf.write(chrom+'\t'+base+'\t'+str(int(base)+1)+'\t'+ref_allele+'\t'+alt_allele+'\t'+line+'\n')
    except:
        print(line)
        
