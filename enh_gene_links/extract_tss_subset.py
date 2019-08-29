import argparse
import pandas as pd
import pdb 
def parse_args():
    parser=argparse.ArgumentParser()
    parser.add_argument("--subset")
    parser.add_argument("--source")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    source_df=pd.read_csv(args.source,header=None,sep='\t')
    subset_df=pd.read_csv(args.subset,header=None,sep='\t')
    source_filtered=source_df[source_df[0].isin(subset_df[0]) & source_df[3].isin(subset_df[3])]
    source_filtered.to_csv(args.outf,index=False,header=False,sep='\t')
    
if __name__=="__main__":
    main() 
