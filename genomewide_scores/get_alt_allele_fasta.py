#get alternate allele
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="swap reference allele to alternate allele in fasta input for SVM")
    parser.add_argument("-fasta")
    parser.add_argument("-allele_pos",type=int,default=500)
    parser.add_argument("-out_fasta")
    return parser.parse_args()
def main():
    args=parse_args()
    outf=open(args.out_fasta,'w')
    fasta=open(args.fasta,'r').read().strip().split('>')
    for line in fasta:
        tokens=line.split('\n')
        if len(tokens)<2:
            #print(tokens)
            continue
        alt=tokens[0].split('/')[-1]
        ref=tokens[0].split('/')[0].split('_')[-1]
        seq=tokens[1]
        if seq[args.allele_pos].lower()==alt.lower():
            alt_seq=seq[0:args.allele_pos]+ref+seq[args.allele_pos+1::]
        else:
            #print(seq[args.allele_pos].lower())
            #print(ref.lower())
            #print("-----------")
            assert seq[args.allele_pos].lower()==ref.lower()
            alt_seq=seq[0:args.allele_pos]+alt+seq[args.allele_pos+1::]
        outf.write('>'+tokens[0]+'\n'+alt_seq+'\n')
    outf.close()
    
if __name__=="__main__":
    main()
    
