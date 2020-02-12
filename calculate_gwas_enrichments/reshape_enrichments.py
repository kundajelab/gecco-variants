import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="reshape enrichment matrix for visualization")
    parser.add_argument("--input_mat")
    parser.add_argument("--output_mat")
    return parser.parse_args()

def main():
    args=parse_args()
    input_mat=open(args.input_mat,'r').read().strip().split('\n')
    outf=open(args.output_mat,'w')
    outf.write('\t'.join(['pvalue','tissue','enrichment'])+'\n')
    header=input_mat[0].split('\t')
    for row in input_mat[1::]:
        tokens=row.split('\t')
        pval=tokens[0]
        for i in range (1,len(tokens)):
            cur_header_field=header[i]
            cur_val=tokens[i]
            outf.write('\t'.join([pval,cur_header_field,cur_val])+'\n')
if __name__=="__main__":
    main()
    
    
