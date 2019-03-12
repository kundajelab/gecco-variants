import random
data=open('basset_input.bed','r').read().split('\n') 
while '' in data: 
    data.remove('') 
toreplace=open('toreplace.txt','r').read().split('\n')
toreplace.remove('') 
replace_dict=dict() 
choices=['A','T','C','G'] 
for line in toreplace: 
    tokens=line.split('\t') 
    #print str(tokens) 
    chrom=tokens[0] 
    pos=tokens[1] 
    ref=tokens[2] 
    alt=ref
    while alt==ref: 
        alt=random.choice(choices) 
    replace_dict[tuple([chrom,pos])]=[ref,alt]
#print str(replace_dict) 
print "built replacement dict" 
outf=open('basset_input.nomissed.bed','w') 
for line in data: 
    tokens=line.split('\t') 
    entry=tuple([tokens[0],tokens[1]])
    if entry not in replace_dict: 
        outf.write(line+'\n') 
    else: 
        print "HIT!" 
        ref_base=replace_dict[entry][0] 
        alt_base=replace_dict[entry][1] 
        outf.write(tokens[0]+'\t'+tokens[1]+'\t'+tokens[2]+'\t'+ref_base+'\t'+alt_base+'\t'+'\t'.join(tokens[5::])+'\n')

