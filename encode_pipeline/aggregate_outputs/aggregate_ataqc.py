import argparse 
import json 
import pdb 
import pandas as pd 
from pandas.io.json import json_normalize 

def parse_args(): 
    parser=argparse.ArgumentParser(description="aggregate ataqc metrics for all samples in a single report")
    parser.add_argument("--ataqc_files",default="/oak/stanford/groups/akundaje/projects/alzheimers_parkinsons/ataqc.json") 
    parser.add_argument("--outf",default="report.txt") 
    parser.add_argument("--mitra_prefix",default="http://mitra.stanford.edu/kundaje/projects/alzheimers_parkinsons/") 
    parser.add_argument("--prefix_to_drop_for_oak",default="/oak/stanford/groups/akundaje/projects/alzheimers_parkinsons/")
    parser.add_argument("--column_order",default="columns.txt",help="order of columns in output tsv")
    return parser.parse_args() 


def main(): 
    args=parse_args() 
    ataqc_files=open(args.ataqc_files,'r').read().strip().split('\n') 
    outf=open(args.outf,'w')
    reports=[] 
    samples=[]
    summary_df = None
    for f in ataqc_files: 
        #get the mitra link for the html ataqc report 
        mitra_file_path=f.replace(args.prefix_to_drop_for_oak,args.mitra_prefix).replace('.json','.html')
        print(mitra_file_path)
        reports.append(mitra_file_path)
        #get the sample name 
        tokens=f.split('/') 
        sample=tokens[9]
        samples.append(sample)
        try:
            data=json.load(open(f,'r')) 
        except: 
            print("could not load:"+str(f))
            continue 
        #flatten the json 
        json_normalized=json_normalize(data) 
        if summary_df is None: 
            summary_df=json_normalized 
        else: 
            summary_df=pd.concat([summary_df,json_normalized],axis=0)
    summary_df['Report']=reports
    summary_df['Sample']=samples 
    column_order=open(args.column_order,'r').read().strip().split('\n') 
    summary_df=summary_df[column_order]
    summary_df.to_csv(outf,sep='\t',index=False)

if __name__=="__main__": 
    main() 
