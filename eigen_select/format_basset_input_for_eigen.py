data=open('basset_input.bed','r').read().split('\n') 
while '' in data: 
    data.remove('') 
outf=open('eigen_input.bed','w')
for line in data: 
    tokens=line.split('\t') 
    chrom=tokens[0].replace('chr','') 
    startpos=int(tokens[1])-1
    endpos=tokens[1] 
    outf.write(chrom+'\t'+str(startpos)+'\t'+str(endpos)+'\n')
    
