import argparse 
import pandas as pd 
import pdb 
import random
import math

#constants
pos_offset=1000000
maf_tolerance=0.01
gc_tolerance=0.01

def parse_args(): 
    parser=argparse.ArgumentParser(description="generate matched negative set for GECCO MPRA validation")
    parser.add_argument("--positive_set_file",default="positive_candidates.tsv")
    parser.add_argument("--positive_set_file_name_col",type=int,default=0)
    parser.add_argument("--gwas_annotation_dir",default="/oak/stanford/groups/akundaje/lab_data/kundaje/projects/GECCO/annotated_colorectal_cancer_gwas_summary_statistics")
    parser.add_argument("--negs_per_pos",type=int,default=2,help="number of negative candidates to genearte for each positive")
    parser.add_argument("--outf",default="matched_negative_candidates")
    parser.add_argument("--nohits1",default="nohits1")
    parser.add_argument("--nohits2",default="nohits2")
    return parser.parse_args() 

def make_string(df): 
    cols=['Chrom','Pos1','Pos2','Allele1','Allele2','Freq1','P-value','GC%','NearestGene','DistTSS','DistDNASE','PLS','ELS','CTCF','DNase']
    values=[df._name]
    for c in cols: 
        values.append(str(df[c]))
    return '\t'.join(values)

def filter_tissue_state(state_val,state_name,candidate_negatives): 
    if ((type(state_val)!=str) and (math.isnan(state_val))): 
        #not active in any tissue
        return candidate_negatives[pd.isnull(candidate_negatives[state_name])]

    elif (("intestine" in state_val)==True):
        candidate_negatives=candidate_negatives[candidate_negatives[state_name].str.contains("intestine")==True]
        if (state_val.count(';')<5):
            #specific to intestines
            return candidate_negatives[candidate_negatives[state_name].str.count(';')<5]
        else: 
            #active in intestines, but also in other tissues
            return candidate_negatives[candidate_negatives[state_name].str.count(';')>=5]
    else: 
        filter1=pd.isnull(candidate_negatives[state_name])==False
        filter2=candidate_negatives[state_name].str.contains("intestine")==False
        candidate_negatives=candidate_negatives[filter1 & filter2]
        #not specific, but not active in intestine 
        if state_val.count(';')>4: 
            return candidate_negatives[candidate_negatives[state_name].str.count(';')>4] 

        #specific, but not active in intestine 
        #(just pick first active tissue) 
        state_val=state_val.split(';')[0] 
        filter3=candidate_negatives[state_name].str.contains(state_val)==True
        filter4=candidate_negatives[state_name].str.count(';')<5 
        return candidate_negatives[filter3 & filter4] 


def main(): 
    args=parse_args() 
    #open the output file 
    outf=open(args.outf,'w') 
    nohits1=open(args.nohits1,'w')
    nohits2=open(args.nohits2,'w')
    #split the positive SNPs by chromosome 
    chrom_to_snp=dict() 
    positives=pd.read_csv(args.positive_set_file,header=0,sep='\t')
    for index,row in positives.iterrows():
        entry=row[args.positive_set_file_name_col] 
        cur_chrom=entry.split(':')[0] 
        if cur_chrom not in chrom_to_snp: 
            chrom_to_snp[cur_chrom]=[entry] 
        else: 
            chrom_to_snp[cur_chrom].append(entry) 
    print("assigned SNPs to chroms") 
    for chrom in chrom_to_snp: 
        #load the variants associated w/ the chromosome 
        annotations=args.gwas_annotation_dir+'/'+'annotations.chr'+str(chrom)+'.bed'
        data=pd.read_csv(annotations,header=0,sep='\t',index_col=0) 
        nrows=data.shape[0] 
        print("loaded annotations for chrom:"+str(chrom))
        #get the annotations for the positive SNP 
        for pos_snp in chrom_to_snp[chrom]: 
            pos_snp_annotation=data.loc[pos_snp] 

            #get position buffer 
            snp_pos=pos_snp_annotation['Pos1']
            buffer_low=max(1,snp_pos-pos_offset)
            buffer_high=min(nrows,snp_pos+pos_offset)
            
            maf=pos_snp_annotation['Freq1']
            maf_low=max(0,maf-maf_tolerance)
            maf_high=min(1,maf+maf_tolerance)

            gc=pos_snp_annotation['GC%']
            gc_low=max(0,gc-gc_tolerance)
            gc_high=min(1,gc+gc_tolerance)
            
            dist_tss=pos_snp_annotation['DistTSS']
            if dist_tss < 2000: 
                dist_tss_low=0 
                dist_tss_high=2000
            elif dist_tss < 10000: 
                dist_tss_low=2000
                dist_tss_high=10000
            else: 
                dist_tss_low=10000
                dist_tss_high=2*dist_tss
            
            dist_dnase=pos_snp_annotation['DistDNASE']
            if dist_dnase < 100: 
                dist_dnase_low=0 
                dist_dnase_high=100
            elif dist_dnase < 2000: 
                dist_dnase_low=100
                dist_dnase_high=2000
            elif dist_dnase<10000: 
                dist_dnase_low=2000
                dist_dnase_high=10000
            else: 
                dist_dnase_low=10000
                dist_dnase_high=2*dist_dnase 
            
            #apply non-tissue-specific filters 
            pos_filters=(data['Pos1']>buffer_high) | (data['Pos1']<buffer_low)
            pval_filters=(data['P-value']>0.05)
            maf_filters=(data['Freq1']>=maf_low) & (data['Freq1']<=maf_high)
            gc_filters=(data['GC%']>=gc_low) & (data['GC%']<=gc_high)
            tss_filters=(data['DistTSS']>=dist_tss_low) & (data['DistTSS']<=dist_tss_high)
            dnase_filters=(data['DistDNASE']>=dist_dnase_low) & (data['DistDNASE']<=dist_dnase_high)
            all_filters=pos_filters & pval_filters & maf_filters & gc_filters & tss_filters & dnase_filters 
            candidate_negatives=data[all_filters] 
            if candidate_negatives.shape[0]<1: 
                nohits1.write(make_string(pos_snp_annotation)+'\n')
                continue
                
            PLS=pos_snp_annotation['PLS'] 
            ELS=pos_snp_annotation['ELS'] 
            ctcf=pos_snp_annotation['CTCF'] 
            dnase=pos_snp_annotation['DNase'] 

            candidate_negatives=filter_tissue_state(PLS,'PLS',candidate_negatives)
            candidate_negatives=filter_tissue_state(ELS,'ELS',candidate_negatives) 
            candidate_negatives=filter_tissue_state(ctcf,'CTCF',candidate_negatives) 
            candidate_negatives=filter_tissue_state(dnase,'DNase',candidate_negatives) 
            
            if candidate_negatives.shape[0]<1: 
                nohits2.write(make_string(pos_snp_annotation)+'\n')
                continue

    
if __name__=="__main__": 
    main() 

