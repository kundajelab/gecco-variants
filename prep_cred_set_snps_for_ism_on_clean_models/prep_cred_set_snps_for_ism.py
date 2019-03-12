import pdb 
import argparse
import pandas as pd
from os import listdir
from os.path import isfile, join

def parse_args():
    parser=argparse.ArgumentParser(description="identify credible set snps not in ld with coding var. Write those in bed format for model ism")
    parser.add_argument("--exon_snps")
    parser.add_argument("--cred_set_snps")
    parser.add_argument("--sig_locus_dir")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    exon_snps=pd.read_csv(args.exon_snps,header=None,sep='\t',index_col=5)
    cred_set_snps=pd.read_csv(args.cred_set_snps,header=None,sep='\t')
    locus_files = [f for f in listdir(args.sig_locus_dir) if isfile(join(args.sig_locus_dir, f))]
    snp_dict=dict()
    coding_labels=['frameshift_variant','frameshift_variant,NMD_transcript_variant','missense_variant','missense_variant,NMD_transcript_variant','missense_variant,splice_region_variant','stop_gained']
    print("loaded data") 
    for f in locus_files:
        locus_snps=open('/'.join([args.sig_locus_dir,f]),'r').read().strip().split('\n')
        for line in locus_snps[1::]:
            try:
                snp=line.split('\t')[0]
                snp_chrom_pos=snp.split('_')[0]
                if snp in exon_snps.index:
                    function="exon"
                else:
                    function="noncoding"
                snp_dict[snp_chrom_pos]=[f,snp,function]
            except:
                print("skipping:"+str(snp_chrom_pos))
        #print("annotated:"+str(f))
    print("done annotating locus files")
    outf=open(args.outf,'w')
    for index,row in cred_set_snps.iterrows():
        snp_chrom_pos=row[0].replace('chr','')
        cur_locus=snp_dict[snp_chrom_pos][0]
        cur_snp_name=snp_dict[snp_chrom_pos][1]
        cur_snp_function=snp_dict[snp_chrom_pos][2]
        #check for ld coding snps
        ld_with_coding=False
        for snp in snp_dict:
            snp_locus=snp_dict[snp][0]
            if snp_locus==cur_locus:
                snp_function=snp_dict[snp][2]
                #print(snp_function) 
                if snp_function =="exon":
                    print("exon") 
                    ld_with_coding=True
                    break
        if ld_with_coding==False:
            #no coding ld snps, keep this one
            alleles=cur_snp_name.split('_')[1].split('/')
            ref=alleles[0]
            alt=alleles[1]
            chrom=snp_chrom_pos.split(':')[0]
            pos=snp_chrom_pos.split(':')[1]
            outf.write('chr'+chrom+'\t'+pos+'\t'+ref+'\t'+alt+'\t'+cur_snp_name+'\n')
            

if __name__=="__main__":
    main()
    
    
