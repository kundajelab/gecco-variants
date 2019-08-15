import sys
data=open(sys.argv[1],'r').read().strip().split("\n")
outf=open(sys.argv[1]+".expanded",'w')
outf.write("\t".join(['Chrom','StartPos','EndPos','Ref','Alt','Rsid'])+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    outf.write(tokens[0]+'\t'+tokens[1]+'\t'+str(int(tokens[1])+1)+'\t'+tokens[2]+'\t'+tokens[3]+'\t'+tokens[4]+'\n')
    
#99percent_cred_set.bed  99percent_cred_set_no_ld_coding.bed  variants.with.rsid.bed
