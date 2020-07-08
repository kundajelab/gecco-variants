import pysam
import pandas as pd 
ref=pysam.FastaFile("/mnt/data/male.hg19.fa")
data=pd.read_csv('snps.in.regions.with.alleles.bed',header=0,sep='\t')
out_ref=open('snps.in.regions.with.alleles.ref.fa','w')
out_alt=open('snps.in.regions.wtih.alleles.alt.fa','w')
flank=500
for index,row in data.iterrows():
    chrom=row['chrom']
    pos=row['pos0']
    start=pos-flank
    end=pos+flank
    fasta_seq=ref.fetch(chrom,start,end)
    ref_seq=fasta_seq[0:flank]+row['ref']
    topad=2*flank-len(ref_seq)
    ref_seq=ref_seq+fasta_seq[flank+1:flank+1+topad]
    
    assert len(ref_seq)==2*flank
    alt_seq=fasta_seq[0:flank]+row['alt']
    topad=2*flank-len(alt_seq) 
    alt_seq=alt_seq+fasta_seq[flank+1:flank+1+topad]
    assert len(alt_seq)==2*flank
    if len(row['alt'])>1:
        print(row['alt'])
    out_ref.write('>'+row['name']+'\n'+ref_seq+'\n')
    out_alt.write('>'+row['name']+'\n'+alt_seq+'\n')
out_ref.close()
out_alt.close()

