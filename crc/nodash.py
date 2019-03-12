data=open('basset_input.bed','r').read().split('\n') 
data.remove('') 

outf=open('nodash.bed','w') 
for line in data: 
    tokens=line.split('\t') 
    tokens[2]=tokens[2].replace('-','') 
    outf.write('\t'.join(tokens)+'\n') 
