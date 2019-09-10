import argparse
import pdb
import pandas as pd
import numpy as np
from scipy.stats import norm

def parse_args():
    parser=argparse.ArgumentParser()
    parser.add_argument("--peak_overlap_bed_files",nargs="+")
    parser.add_argument("--gwas_all_bed")
    parser.add_argument("--outf")
    parser.add_argument("--increment",type=float,default=0.01)
    parser.add_argument("--pseudocount",type=float,default=0.001)
    return parser.parse_args()

def main():
    args=parse_args()
    outf=open(args.outf,'w')

    all_gwas_hits=pd.read_csv(args.gwas_all_bed,header=None,sep='\t')
    print("loaded all gwas hits")
    num_all_gwas_hits=all_gwas_hits.shape[0] #number of gwas  hits
    #convert to -log10(pval), round to 0.01 increment 
    all_gwas_hits[8]=round(-1*np.log10(all_gwas_hits[7]),int(-1*np.log10(args.increment)))
    #get the max pvalue
    max_pval=max(all_gwas_hits[8])
    all_gwas_dict=dict()
    for i in np.arange(0,max_pval, args.increment):
        all_gwas_dict[i]=(all_gwas_hits[8]>i).sum()
    print("annotated all GWAS hits")
    
    all_enrichments={}    
    for peak_overlap_bed_file in args.peak_overlap_bed_files:
        peak_overlap_bed=pd.read_csv(peak_overlap_bed_file,header=None,sep='\t')
        print("loaded:"+peak_overlap_bed_file)
        num_peak_overlap_gwas=peak_overlap_bed.shape[0] #number of gwas hits overlapping peaks 
        peak_overlap_bed[8]=round(-1*np.log10(peak_overlap_bed[7]),int(-1*np.log10(args.increment)))
        #convert to dict
        peak_overlap_dict=dict()
        for i in np.arange(0,max_pval,args.increment):
            peak_overlap_dict[i]=(peak_overlap_bed[8]>i).sum()
        #get enrichment
        expected=num_peak_overlap_gwas/(num_all_gwas_hits+args.pseudocount)
        print("expected:"+str(expected))
        enrichments={}
        for i in np.arange(0,max_pval,args.increment):
            observed=peak_overlap_dict[i]/(all_gwas_dict[i]+args.pseudocount)
            print("observed:"+str(observed))
            fold_change=observed/expected
            enrichments[i]=fold_change
            
        all_enrichments[peak_overlap_bed_file]=enrichments

    #write the output
    outf=open(args.outf,'w')
    files=list(all_enrichments.keys())
    outf.write('pval'+'\t'+'\t'.join(files)+'\n')
    for i in np.arange(0,max_pval,args.increment):
        outf.write(str(i))
        for filename in files:
            outf.write('\t'+str(all_enrichments[filename][i]))
        outf.write('\n')
        
                
if __name__=="__main__":
    main() 
