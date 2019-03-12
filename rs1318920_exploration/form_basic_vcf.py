data=open("chr10-101351704-A-G_credible_set.csv",'r').read().strip().split('\n')
outf=open("chr10-101351704-A-G_credible_set.vcf",'w')
outf.write("#CHROM\tPOS\tID\tREF\tALT\n")
for line in data[1::]:
    tokens=line.split('\t')
    chrom=tokens[0].split(':')[0]
    pos=tokens[0].split(':')[1].split('_')[0]
    alleles=tokens[0].split(':')[1].split('_')[1].split('/') 
    ref=alleles[0]
    alt=alleles[1]
    rsid=tokens[1]
    outf.write(chrom+'\t'+pos+'\t'+rsid+'\t'+ref+'\t'+alt+'\n')
    
