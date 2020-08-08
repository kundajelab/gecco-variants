import pysam
import argparse
import pandas as pd 
def parse_args():
    parser=argparse.ArgumentParser(description="geneate reference & alternate fasta files from GWAS sum stats")
    parser.add_argument("-ref_fasta")
    parser.add_argument("-chrom_sizes")
    parser.add_argument("-prefix")
    parser.add_argument("-chrom")
    parser.add_argument("-suffix")
    parser.add_argument("-chrom_col")
    parser.add_argument("-pos1_col")
    parser.add_argument("-name_col")
    parser.add_argument("-out_prefix")
    parser.add_argument("-ref_allele_col")
    parser.add_argument("-alt_allele_col") 
    parser.add_argument("--flank",type=int,default=500)
    return parser.parse_args()

def main():
    args=parse_args()
    fasta_ref=pysam.FastaFile(args.ref_fasta)
    chromsizes=pd.read_csv(args.chrom_sizes,header=None,sep='\t',index_col=0)
    print(str(chromsizes))
    data=pd.read_csv(''.join([args.prefix,args.chrom,args.suffix]),header=0,sep='\t')
    print("loaded data frame")
    out_ref=open(''.join([args.out_prefix,args.chrom,'.ref.fa']),'w')
    out_alt=open(''.join([args.out_prefix,args.chrom,'.alt.fa']),'w')
    num_snps=str(data.shape[0])
    for index,row in data.iterrows():
        if index%1000==0:
            print(str(index)+'/'+num_snps)
        cur_chrom=str(row[args.chrom_col])
        if cur_chrom.startswith('chr')==False:
            cur_chrom='chr'+cur_chrom
        
        pos1=row[args.pos1_col] #1-indexed SNP position 
        pos0=pos1-1 #0-indexed SNP position
    
        ref=row[args.ref_allele_col]
        alt=row[args.alt_allele_col]
        left_flank=fasta_ref.fetch(cur_chrom,max([0,pos0-args.flank]),pos0)
        topad=args.flank-len(left_flank)
        left_flank="N"*topad+left_flank 
        assert len(left_flank)==args.flank
        right_flank=fasta_ref.fetch(cur_chrom,pos0+1,min([pos0+args.flank,chromsizes.loc[cur_chrom][1]]))
        topad=args.flank-1-len(right_flank)
        right_flank=right_flank+"N"*topad
        assert len(right_flank) == (args.flank -1)
        ref_seq=left_flank+ref+right_flank
        alt_seq=left_flank+alt+right_flank
        assert len(ref_seq)==(2*args.flank)
        assert len(alt_seq)==(2*args.flank)
        
        snp_name=row[args.name_col]
        out_ref.write(">"+snp_name+'\n'+ref_seq+'\n')
        out_alt.write(">"+snp_name+'\n'+alt_seq+'\n')
    out_ref.close()
    out_alt.close() 
    
if __name__=="__main__":
    main()
    
