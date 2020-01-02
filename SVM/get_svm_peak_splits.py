import argparse
from kerasAC.splits import *
import pandas as pd
import pysam


def parse_args():
    parser=argparse.ArgumentParser(description="generate positive inputs for svm")
    parser.add_argument("--narrowPeak")
    parser.add_argument("--ntrain",type=int,default=60000)
    parser.add_argument("--ntest",type=int,default=None,help="None means that all peak in training split will be used")
    parser.add_argument("--out_prefix")
    parser.add_argument("--genome")
    return parser.parse_args()
def main():
    args=parse_args()
    #load the narrowPeak file
    peaks=pd.read_csv(args.narrowPeak,header=None,sep='\t')
    #sort by column 9 (8 0-indexed) , which is the qValue, from highest to lowest
    sorted_peaks=peaks.sort_values(by=8,ascending=False)
    print(sorted_peaks.head())

    #open the output files 
    outputs_train=dict()
    outputs_test=dict() 
    for fold in range(10):
        print("processing fold:"+str(fold))
        outputs_train=open(args.out_prefix+'.train.'+str(fold),'w')
        outputs_test=open(args.out_prefix+'.test.'+str(fold),'w')
        num_train=0
        num_test=0
        max_train=args.ntrain
        if max_train is None:
            max_train=sorted_peaks.shape[0]
        max_test=args.ntest
        if max_test is None:
            max_test=sorted_peaks.shape[0] 
        args.fold=fold
        args.train_chroms=None
        args.validation_chroms=None
        args.predict_chroms=None
        train_chroms=get_chroms(args,'train')
        valid_chroms=get_chroms(args,'valid')
        test_chroms=get_chroms(args,'test')
        train_chroms=train_chroms+valid_chroms
        train_dict=dict()
        for chrom in train_chroms:
            train_dict[chrom]=1
        test_dict=dict()
        for chrom in test_chroms:
            test_dict[chrom]=1
            
        for index,row in sorted_peaks.iterrows():
            cur_chrom=row[0]
            if cur_chrom in train_dict:
                if num_train<max_train:
                    num_train+=1
                    #add to train list
                    outputs_train.write('\t'.join([str(i) for i in row])+'\n')
            else:
                if num_test<max_test:
                    num_test+=1
                    #add to test list
                    outputs_test.write('\t'.join([str(i) for i in row])+'\n')
        outputs_train.close()
        outputs_test.close()
        
        
    
if __name__=="__main__":
    main()
    
    
