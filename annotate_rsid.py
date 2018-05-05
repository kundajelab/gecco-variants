#Add Kaviar annotations for variants of interest
variants=open("summary.ism.combined",'r').read().strip().split('\n')
annotations=open("kaviar.outputs.txt",'r').read().strip().split('\n')
anno_dict=dict()
for line in annotations:
    tokens=line.split()
    if tokens[-1].startswith('rs'):
        entry=tuple(tokens[0:2])
        anno_dict[entry]=tokens[-1]
additional=open("all.found",'r').read().strip().split('\n')
for line in additional:
    tokens=line.split('\t')
    entry1=tuple(tokens[1:3])
    entry2=tuple([tokens[1],tokens[3]])
    snp=tokens[4]
    anno_dict[entry1]=snp
    anno_dict[entry2]=snp
    
print("generated annotation dict")
outf=open("summary.ism.combined.rsid",'w')
outf.write('rsid'+'\t'+variants[0]+'\n')
for line in variants[1::]:
    tokens=line.split()
    chrom='chr'+tokens[0]
    pos=tokens[1]
    entry=tuple([chrom,pos])
    try:
        rsid=anno_dict[entry]
    except:
        print(line)
        rsid="NA"
    outf.write(rsid+'\t'+line+'\n')
    
