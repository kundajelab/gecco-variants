import sys
import pandas as pd 
inputf=sys.argv[1]
data=open(inputf,'r').read().strip().split('\n')
outf=open(inputf+'.filtered','w')
seen=dict() 
for line in data:
    tokens=line.split('\t')
    name=tokens[0]
    if name in seen:
        print(name)
        continue
    else:
        seen[name]=1
        outf.write(line+'\n')
