f1=open("variants.bed",'r').read().strip().split('\n')
f2=open("summary.ism.combined.rsid",'r').read().strip().split('\n')
snp_to_pos=dict()
for line in f2[1::]:
    tokens=line.split('\t')
    rsid=tokens[0]
    chrom='chr'+tokens[1]
    pos=tokens[2]
    snp_to_pos[(chrom,pos)]=rsid
outf=open('variants.with.rsid.bed','w')
outf.write('Chrom\tPos\tRef\tAlt\tRsid\n')
for line in f1[1::]:
    tokens=line.split('\t')
    rsid=snp_to_pos[(tokens[0],tokens[1])]
    outf.write(line+'\t'+rsid+'\n')
    
