data=open("allele_counts_500_subjects.tsv",'r').read().strip().split('\n')
outf=open("allele_counts_500_subjects.bed",'w')
for line in data[1::]:
    tokens=line.split()
    outf.write('chr'+tokens[0]+'\t'+tokens[1]+'\t'+str(int(tokens[1])+1)+'\t'+'\t'.join(tokens[2::])+'\n')
    
