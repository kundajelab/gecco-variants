data=open("summary.ism.combined.rsid",'r').read().strip().split('\n')
outf=open("summary.sim.combined.bed",'w')
for line in data[1::]:
    tokens=line.split('\t')
    chrom=tokens[1]
    pos_start=str(int(tokens[2]))
    pos_end=str(int(tokens[2])+1)
    outf.write('chr'+chrom+'\t'+pos_start+'\t'+pos_end+'\n')
    
