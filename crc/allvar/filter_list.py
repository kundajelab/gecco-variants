import sys 
original=open(sys.argv[1],'r').read().split('\n') 
while '' in original: 
    original.remove('') 
filtered=open(sys.argv[2],'r').read().split('\n') 
while '' in filtered: 
    filtered.remove('') 
outf=open(sys.argv[1]+'.postfilter','w') 
var_to_type=dict() 
var_to_gene=dict() 
for line in original: 
    tokens=line.split('\t') 
    print str(tokens) 
    vartype=tokens[0] 
    vargene=tokens[1] 
    candidates=tokens[2::]
    for c in candidates: 
        var_to_type[c]=vartype 
        var_to_gene[c]=vargene 
for line in filtered: 
    tokens=line.split('\t') 
    if len(tokens)>1: 
        mafvals=tokens[1].split(',') 
        if '' in mafvals: 
            mafvals.remove('') 
        if len(mafvals)==0: 
            continue 
        print str(mafvals) 
        mafvals=[float(i) for i in mafvals] 
        maf =1-max(mafvals) 
        if maf < 0.01: 
            outf.write(tokens[0]+'\t'+str(maf)+'\t'+var_to_gene[tokens[0]]+'\t'+var_to_type[tokens[0]]+'\n')
