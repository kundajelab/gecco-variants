import argparse
import math
def parse_args():
    parser=argparse.ArgumentParser(description="generate hammock tracks from GECCO GWAS summary statistics")
    parser.add_argument("--prefix")
    parser.add_argument("--suffix")
    parser.add_argument("--wald_stderr",action="store_true")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    index=0
    chroms=[str(i) for i in range(1,23)]
    outf=open(args.outf,'w')
    for chrom in chroms:
        print(chrom)
        data=open(args.prefix+chrom+args.suffix,'r').read().strip().split('\n')
        c=0 
        for line in data[1::]:
            c+=1
            if c%10000==0:
                print(c)
            tokens=line.split('\t')
            chrom='chr'+tokens[0].split(":")[0]
            endpos=int(tokens[-1])
            startpos=endpos-1
            allele1=tokens[1]
            allele2=tokens[2]
            freq1=tokens[3]
            zscore=tokens[-4]
            pvalue=-10*math.log10(float(tokens[-3]))
            if pvalue < 73.01:
                category=str(2)
            else:
                category=str(1)
            name=tokens[0].replace(':','_').replace('/','_')
            
            #strand=tokens[-2][-1] 
            outf.write(chrom+'\t'
                       +str(startpos)+'\t'
                       +str(endpos)+'\t'
                       +'id:'+str(index)+','
                       +'name:"'+name+'",'
                       +'scorelst:['+str(pvalue)+','+zscore+']'+','
                       +'category:'+str(category)+','
                       +'desc:"name='+name+','+' freq 1='+freq1+', '+'allele 1='+allele1+', '+'allele 2='+allele2+'"\n')
            index+=1 
if __name__=="__main__":
    main()
    
