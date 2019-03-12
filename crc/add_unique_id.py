allvar=open('allvar/all_variation.sliced','r').read().split('\n') 
if '' in allvar: 
    allvar.remove('') 
print 'read in allvar' 
data=open("basset_input.bed",'r').read().split('\n') 
data.remove('') 
data_dict=dict() 
for line in data: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    pos=tokens[1] 
    rsid=tokens[0]+':'+str(int(tokens[1])-1)+'-'+tokens[1]
    tokens[2]=rsid 
    data_dict[tuple([chrom,pos])]=tokens
print "made dictionary of positions" 
outf=open('basset_input.uniquers.bed','w') 
c=0 
for line in allvar: 
    c+=1 
    if c%1000000==0: 
        print str(c) 
    tokens=line.split('\t') 
    entry=tuple([tokens[0],tokens[2]])
    rsid=tokens[3] 
    if entry in data_dict:
        data_dict[entry][2]=rsid 
print "did data pass" 
for entry in data_dict: 
    value=data_dict[entry] 
    outf.write('\t'.join(value)+'\n')

