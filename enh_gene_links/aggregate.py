import pdb
import pandas as pd 
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="aggregate augmented intersections")
    parser.add_argument("--intersections",nargs="+")
    parser.add_argument("--names",nargs="+")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    merged=None
    for i in range(len(args.intersections)):
        cur_data=pd.read_csv(args.intersections[i],header=None,sep='\t')
        cur_data[10]=args.names[i]
        #promoter minus mean enhancer 
        cur_data[11]=cur_data[3] - 0.5*(cur_data[8]+cur_data[9])
        cur_data[11]=cur_data[11].round() 
        if merged is None:
            merged=cur_data
        else:
            merged=pd.concat((merged,cur_data),axis=0)
        print("done with:"+str(i))
    merged.to_csv(args.outf,index=False,header=False,sep='\t')

        
if __name__=="__main__":
    main()
    
