loci=dict()
mypath="/srv/scratch/annashch/gecco/colorectal_cancer_gwas_hits_for_anna/credible_sets"
from os import listdir
from os.path import isfile, join
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
for f in onlyfiles:
    data=open(mypath+'/'+f,'r').read().strip().split('\n')
    for line in data[1::]:
        tokens=line.split("_")[0].split(':')
        chrom='chr'+tokens[0]
        pos=tokens[1]
        loci[(chrom,pos)]=f
print("got mapping of snp to locus")

snps_in_peaks=open("gwas.snps.in.peaks.txt",'r').read().strip().split('\n')
locus_to_peak_snps=dict()
for line in snps_in_peaks:
    tokens=line.split('\t')
    chrom=tokens[0]
    pos=tokens[1]
    locus=loci[(chrom,pos)]
    if locus not in locus_to_peak_snps:
        locus_to_peak_snps[locus]=1
    else:
        locus_to_peak_snps[locus]+=1
print("mapped peak snps to loci")
outf=open("loci.to.num.peak.snps.txt",'w')
for locus in locus_to_peak_snps:
    outf.write(locus+'\t'+str(locus_to_peak_snps[locus])+'\n')


snps_in_peaks=open("gwas.snps.in.dnase.peaks.txt",'r').read().strip().split('\n')
locus_to_peak_snps=dict()
for line in snps_in_peaks:
    tokens=line.split('\t')
    chrom=tokens[0]
    pos=tokens[1]
    locus=loci[(chrom,pos)]
    if locus not in locus_to_peak_snps:
        locus_to_peak_snps[locus]=1
    else:
        locus_to_peak_snps[locus]+=1
print("mapped peak snps to loci")
outf=open("loci.to.num.dnase.peak.snps.txt",'w')
for locus in locus_to_peak_snps:
    outf.write(locus+'\t'+str(locus_to_peak_snps[locus])+'\n')

snps_in_peaks=open("gwas.snps.in.h3k27ac.peaks.txt",'r').read().strip().split('\n')
locus_to_peak_snps=dict()
for line in snps_in_peaks:
    tokens=line.split('\t')
    chrom=tokens[0]
    pos=tokens[1]
    locus=loci[(chrom,pos)]
    if locus not in locus_to_peak_snps:
        locus_to_peak_snps[locus]=1
    else:
        locus_to_peak_snps[locus]+=1
print("mapped peak snps to loci")
outf=open("loci.to.num.h3k27ac.peak.snps.txt",'w')
for locus in locus_to_peak_snps:
    outf.write(locus+'\t'+str(locus_to_peak_snps[locus])+'\n')

