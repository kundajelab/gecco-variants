source=open('maf','r').read().split('\n') 
while '' in source: 
    source.remove('') 
outf=open('maf.filtered','w') 
c=0 
for line in source[1::]: 
    c+=1 
    if c%1000000==0: 
        print str(c) 
    tokens=line.strip(',').split('\t') 
    snp=tokens[0] 
    mafval=tokens[1].split(',') 
    if len(mafval)>0: 
        try:
            mafval=min([float(i) for i in mafval])
            mafval=min([mafval,1-mafval])
            outf.write(snp+'\t'+str(mafval)+'\n')
        except: 
            continue 
