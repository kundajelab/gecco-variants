cred_set=open("chr10-101351704-A-G_credible_set.csv",'r').read().strip().split('\n')
cadd=open("cadd.csv",'r').read().strip().split('\n')
outf=open('tmp.tsv','w')
cred_header=cred_set[0]
cadd_header=cadd[0]
outf.write(cred_header+'\t'+cadd_header+'\n')
cred_dict=dict()
for line in cred_set[1::]:
    tokens=line.split('\t')
    chrom=tokens[0].split(':')[0]
    pos=tokens[0].split(':')[1].split('_')[0]
    entry=tuple([chrom,pos])
    cred_dict[entry]=line
for line in cadd[1::]:
    tokens=line.split('\t')
    chrom=tokens[0]
    pos=tokens[1]
    key=tuple([chrom,pos])
    cred_info=cred_dict[key]
    outf.write(cred_info+'\t'+line+'\n')
    
