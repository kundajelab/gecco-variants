import argparse
import pandas as pd

def parse_args():
    parser=argparse.ArgumentParser(description="add rs id numbers from 1kg to the GECCO data")
    parser.add_argument("--bim")
    parser.add_argument("--munged")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    bim_dict={}
    bim=open(args.bim,'r').read().strip().split('\n')
    print("loaded bim file")
    for line in bim:
        tokens=line.split()
        rsid=tokens[1]
        pos=tokens[3]
        bim_dict[pos]=rsid
    print("generated bim file dictionary")
    outf=open(args.outf,'w')
    gecco=pd.read_csv(args.munged,header=0,sep='\t')
    print("loaded munged file") 
    for index,line in gecco.iterrows(): 
        snp_pos=line['SNP'].split(':')[1].split('_')[0]
        if snp_pos in bim_dict:
            rsid=bim_dict[snp_pos]
            outf.write(rsid+'\t'+'\t'.join([str(i) for i in line[1::]])+'\n')
    outf.close()
    
if __name__=="__main__":
    main()
    
