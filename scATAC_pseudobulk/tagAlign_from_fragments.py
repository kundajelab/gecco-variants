import argparse
import gzip 
def parse_args():
    parser=argparse.ArgumentParser()
    parser.add_argument("--frags")
    parser.add_argument("--read_length",type=int,default=99)
    parser.add_argument("--outf")
    parser.add_argument("--chrom_sizes",default='hg38.chrom.sizes') 
    return parser.parse_args()

def main():
    args=parse_args()
    outf=open(args.outf,'w')
    chrom_sizes=open(args.chrom_sizes,'r').read().strip().split('\n')
    chrom_size_dict=dict()
    for line in chrom_sizes:
        tokens=line.split('\t')
        chrom_size_dict[tokens[0]]=int(tokens[1])
    read_length=args.read_length
    index=0
    if args.frags.endswith('.gz'):
        f=gzip.open(args.frags,'rb')
        zipped_input=True
    else:
        f=open(args.frags,'r')
        zipped_input=False
    for cur_line in f:
        if zipped_input==True:
            cur_line=cur_line.decode(encoding="utf-8")
        if index%100000==0:
            print(index)
        index+=1
        tokens=cur_line.split('\t')
        chrom=tokens[0]
        tok1=int(float(tokens[1]))
        tok2=int(float(tokens[2]))
        pos_start=tok1-1
        pos_end=tok1+read_length
        neg_end=tok2-1
        neg_start=neg_end-read_length
        if pos_start>0:
            if pos_end <chrom_size_dict[chrom]: 
                outf.write('\t'.join([chrom,str(pos_start),str(pos_end),'N','1000','+'])+'\n')
        if neg_start >0:
            if neg_end <chrom_size_dict[chrom]: 
                outf.write('\t'.join([chrom,str(neg_start),str(neg_end),'N','1000','-'])+'\n')                
if __name__=="__main__":
    main()
    
