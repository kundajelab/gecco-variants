data=open('hits.bed','r').read().split('\n') 
while '' in data: 
    data.remove('') 
outf=open('igr.formatted.bed','w') 
for line in data: 
    tokens=line.split('\t') 
    tokens[0]=tokens[0].split(':')[1] 
    info=tokens[4].split(',') 
    fold=info[23] 
    ratio=info[32] 
    outf.write('\t'.join(tokens[0:4])+'\t'+fold+'\t'+ratio+'\n')

