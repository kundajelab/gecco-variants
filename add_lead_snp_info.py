import argparse
import pandas as pd
from os import listdir
from os.path import isfile, join

def parse_args():
    parser=argparse.ArgumentParser(description='extracts and adds p-value to a tsv file with snp chrom and pos')
    parser.add_argument("--input_tsv")
    parser.add_argument("--chrom_col",default=0)
    parser.add_argument("--pos_col",default=1,help='0-indexed')
    parser.add_argument("--cred_set_folder",default="/srv/scratch/annashch/gecco/colorectal_cancer_gwas_hits_for_anna/credible_sets")
    parser.add_argument('--lead_pval_bed',default="/srv/scratch/annashch/gecco/colorectal_cancer_gwas_hits_for_anna/lead_snps.hg19.0indexed.withgwaspval.bed")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    cred_set_dict=dict()
    lead_pvals=open(args.lead_pval_bed,'r').read().strip().split('\n')
    lead_pval_dict=dict()
    for line in lead_pvals:
        tokens=line.split('\t')
        chrom=tokens[0]
        pos=int(tokens[1])
        pval=tokens[-1]
        lead_pval_dict[tuple([chrom,pos])]=pval
    print(lead_pval_dict)
    cred_sets = [f for f in listdir(args.cred_set_folder) if isfile(join(args.cred_set_folder, f))]
    for f in cred_sets:
        lead=f.split('-')
        lead_chrom=lead[0]
        lead_pos=int(lead[1])-1 #0-index
        lead_ref=lead[2]
        lead_alt=lead[3]
        ld_snps=pd.read_csv('/'.join([args.cred_set_folder,f]),header=0,sep='\t')
        for index,row in ld_snps.iterrows():
            snp=row['variant']
            r2=row['r2']
            r=row['r']            
            chrom='chr'+snp.split(':')[0]
            pos=int(snp.split(':')[1].split('_')[0])-1
            lead_pval=lead_pval_dict[tuple([lead_chrom,lead_pos])]
            cred_set_dict[tuple([chrom,pos])]=[lead_chrom,lead_pos,r2,r,lead_pval]
    print("made cred set dict")
    data=open(args.input_tsv,'r').read().strip().split('\n')
    outf=open(args.outf,'w')
    outf.write(data[0]+'\t'+'LeadChrom\tLeadPos\tr^2\tr\tLeadGWASPval\n')
    for line in data[1::]:
        tokens=line.split('\t')
        chrom=tokens[args.chrom_col]
        pos=int(tokens[args.pos_col])
        key=tuple([chrom,pos])
        if key in cred_set_dict:
            lead_info=cred_set_dict[key]
            outf.write(line+'\t'+'\t'.join([str(i) for i in lead_info])+'\n')
        else:
            print(key)
    outf.close()
if __name__=="__main__":
    main()
    

