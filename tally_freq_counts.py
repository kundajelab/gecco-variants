import argparse
import pandas as pd
import pdb

def parse_args():
    parser=argparse.ArgumentParser("Tally allele frequency counts in CRC positive set")
    parser.add_argument("--bin_list",default="positive_crc.merged.bed")
    parser.add_argument("--nbins",type=int,nargs="+",default=[700000,500000,400000,300000,200000,100000,50000,25000])
    parser.add_argument("--thresholds",type=float,nargs="+",default=[0.5,0.4,0.3,0.2,0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.0011])
    parser.add_argument("--positive_maf_intersection",default="positive_maf_intersection.bed")
    parser.add_argument("--outf",default="tally.txt")
    return parser.parse_args()

def main():
    args=parse_args()
    bin_list=pd.read_csv(args.bin_list,sep='\t',header=None)
    print("read bin list")
    thresholds=args.thresholds
    print("got thresholds")
    
    positive_maf_intersection=pd.read_csv(args.positive_maf_intersection,sep='\t',header=None)
    print("read positive maf intersection")
    
    #tally allele counts by bin & frequency
    maf_dict=dict()
    for row in positive_maf_intersection.itertuples():
        
        key='_'.join([str(i) for i in row[1:4]])
        if key not in maf_dict:
            maf_dict[key]=dict()
            for thresh in thresholds:
                maf_dict[key][thresh]=0
        if row[-1]!=0: 
            val=float(row[-2])
            for thresh in thresholds:
                if val < thresh:
                    maf_dict[key][thresh]+=1
                    
    print("created dictionary of allele counts by bin & frequency")

    outf=open(args.outf,'w')
    outf.write('N_positive_regions'+'\t'+'\t'.join([str(i) for i in thresholds])+'\n')
    for cur_nbins in args.nbins:
        print(str(cur_nbins))
        bin_sample=bin_list.sample(cur_nbins)
        aggregate_counts=dict()
        for thresh in thresholds:
            aggregate_counts[thresh]=0
        for cur_bin in bin_sample.itertuples():
            key='_'.join([str(i) for i in cur_bin])
            for thresh in thresholds:
                aggregate_counts[thresh]+=maf_dict[key][thresh]
        #write the allele counts from the current bin sample
        print('writing') 
        outf.write(str(cur_nbins))
        for thresh in thresholds:
            outf.write('\t'+str(aggregate_counts[thresh]))
        outf.write('\n')
        
    

if __name__=="__main__":
    main()
    
    
