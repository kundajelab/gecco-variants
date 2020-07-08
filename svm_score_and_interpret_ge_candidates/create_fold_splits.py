from kerasAC.splits import *
chrom_to_split={}
for split in hg19_splits:
    cur_test_chroms=hg19_splits[split]['test']
    for chrom in cur_test_chroms:
        chrom_to_split[chrom]=split
ref_outfiles={}
alt_outfiles={} 
for i in range(10):
    ref_outfiles[i]=open(str(i)+'.snps.in.regions.with.alleles.ref.fa','w')
    alt_outfiles[i]=open(str(i)+'.snps.in.regions.with.alleles.alt.fa','w')
ref_fa=open('snps.in.regions.with.alleles.ref.fa','r').read().strip().split('>')
alt_fa=open('snps.in.regions.wtih.alleles.alt.fa','r').read().strip().split('>')
for line in ref_fa:
    chrom=line.split('_')[0]
    if chrom=="":
        continue 
    cur_split=chrom_to_split[chrom]
    ref_outfiles[cur_split].write('>'+line)
for line in alt_fa:
    chrom=line.split('_')[0]
    if chrom=="":
        continue 
    cur_split=chrom_to_split[chrom]
    alt_outfiles[cur_split].write('>'+line)
for f in ref_outfiles:
    ref_outfiles[f].close()
for f in alt_outfiles:
    alt_outfiles[f].close()
    
