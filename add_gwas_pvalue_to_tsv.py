import argparse
def parse_args():
    parser=argparse.ArgumentParser(description='extracts and adds p-value to a tsv file with snp chrom and pos')
    parser.add_argument("--input_tsv")
    parser.add_argument("--chrom_col",default=0)
    parser.add_argument("--pos_col",default=1,help='0-indexed')
    parser.add_argument("--gwas_prefix",default="/oak/stanford/groups/akundaje/projects/GECCO/colorectal_cancer_gwas_summary_statistics/METAANALYSIS_JOINT_")
    parser.add_argument("--gwas_suffix",default="_1_SORTED.tbl")
    parser.add_argument("--outf")
    return parser.parse_args()


def main():
    args=parse_args()
    snp_dict=dict()
    snp_data=open(args.input_tsv,'r').read().strip().split('\n')
    outf=open(args.outf,'w')
    outf.write(snp_data[0]+'\t'+'GWAS_PVAL\n')
    for line in snp_data[1::]:
        tokens=line.split('\t')
        
        chrom=tokens[args.chrom_col].upper()
        pos=str(int(tokens[args.pos_col])+1)
        if chrom not in snp_dict:
            snp_dict[chrom]=dict()
        snp_dict[chrom][pos]=line
    print("read in snps")
    for chrom in snp_dict:
        gwas_hits=open(args.gwas_prefix+chrom+args.gwas_suffix,'r').read().split('\n')
        print("loaded gwas for chrom:"+str(chrom))
        for line in gwas_hits[1::]:
            tokens=line.split()
            try:
                pos=tokens[0].split(':')[1].split('_')[0]
                if pos in snp_dict[chrom]:
                    outf.write(snp_dict[chrom][pos]+'\t'+tokens[-3]+'\n')
            except:
                print(tokens) 
    outf.close()
    
if __name__=="__main__":
    main()
    
