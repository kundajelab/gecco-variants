#combine all variants to test with ism into a single set
outf=open('variants.bed','w')
outf.write('Chrom\tPos\tRef\tAlt\n')

#Stephanie's GWAS hits
from os import listdir
from os.path import isfile, join
mypath="/srv/scratch/annashch/gecco/colorectal_cancer_gwas_hits_for_anna/credible_sets"
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
for f in onlyfiles:
    if f.endswith('.tsv'):
        data=open(mypath+'/'+f,'r').read().strip().split('\n')
        for line in data[1::]:
            var=line.split('\t')[0] 
            var=var.split(':')
            chrom='chr'+var[0]
            pos_data=var[1].split('_')
            pos=pos_data[0]
            alleles=pos_data[1].split('/')
            ref=alleles[0]
            alt=alleles[1]
            outf.write(chrom+'\t'+pos+'\t'+ref+'\t'+alt+'\n')

#Michael's CRISPR screens
data=open('/srv/scratch/annashch/gecco/CRC_results.tsv','r').read().strip().split('\n')
for line in data[1::]:
    tokens=line.split('\t')
    chrom=tokens[0]
    pos=tokens[1]
    ref='NA'
    alt='NA'
    outf.write(chrom+'\t'+pos+'\t'+ref+'\t'+alt+'\n')

