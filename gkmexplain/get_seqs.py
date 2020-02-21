import argparse
import pysam
import pandas as pd

def parse_args():
    parser=argparse.ArgumentParser(description="get reference and alternate allele fasta sequences for variants to be interpreted with gkmexplain")
    parser.add_argument("--variant_bed")
    parser.add_argument("--fasta_ref",default="/mnt/data/male.hg19.fa")
    parser.add_argument("--out_prefix")
    parser.add_argument("--flank",type=int,default=500)
    return parser.parse_args()

def main():
    args=parse_args()
    variants=pd.read_csv(args.variant_bed,header=None,sep='\t')
    #print("read in variant file")
    ref=pysam.FastaFile(args.fasta_ref)
    outf_ref=open(args.out_prefix+'.ref.fa','w')
    outf_alt=open(args.out_prefix+'.alt.fa','w')
    for index,row in variants.iterrows():
        chrom=row[0]
        varpos=row[1]
        ref_allele=row[3]
        alt_allele=row[4]
        rsid=row[5]
        coord_start=varpos-args.flank
        coord_end=coord_start+2*args.flank
        seq=ref.fetch(chrom,coord_start,coord_end)
        assert(len(seq)==2*args.flank)
        left_flank=seq[0:args.flank]
        right_flank=seq[args.flank+1::]
        ref_allele_seq=left_flank+ref_allele+right_flank
        alt_allele_seq=left_flank+alt_allele+right_flank
        ref_header=">"+'_'.join([chrom,str(varpos),ref_allele,alt_allele,rsid,ref_allele])
        alt_header=">"+'_'.join([chrom,str(varpos),ref_allele,alt_allele,rsid,alt_allele])
        outf_ref.write('\n'.join([ref_header,ref_allele_seq])+'\n')
        outf_alt.write('\n'.join([alt_header,alt_allele_seq])+'\n')
    outf_ref.close()
    outf_alt.close()
    

if __name__=="__main__":
    main()
    
    
