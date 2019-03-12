#maps cadd scores to variant identifiers 
cadd_file=open('/srv/scratch/annashch/cadd/GECCO_SNP_CADD.tsv','r').read().split('\n') 
input_file=open('/srv/scratch/annashch/crc/basset_input.bed','r').read().split('\n') 
while '' in cadd_file: 
    cadd_file.remove('') 
while '' in input_file: 
    input_file.remove('') 

input_dict=dict() 
for line in input_file: 
    tokens=line.split('\t') 
    chrom=tokens[0]
    pos=tokens[1] 
    name=tokens[2] 
    input_dict[tuple([chrom,pos])]=name 
outf=open('/srv/scratch/annashch/cadd/GECCO_SNP_CADD_ANNOTATED.tsv','w') 
outf.write('RSID\t'+cadd_file[0]+'\n') 
for line in cadd_file[2::]: 
    tokens=line.split('\t') 
    chrom='chr'+tokens[0] 
    pos=tokens[1] 
    tuple1=tuple([chrom,pos]) 
    tuple2=tuple([chrom,str(int(pos)-1)])
    if tuple1 in input_dict: 
        name=input_dict[tuple1]
    else: 
        name=input_dict[tuple2] 
    outf.write(name+'\tchr'+line+'\n')

