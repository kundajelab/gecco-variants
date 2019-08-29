import pandas as pd
import argparse
import pdb 
def parse_args():
    parser=argparse.ArgumentParser(description="extract TSS annotation from gencode")
    parser.add_argument("--gtf",default="gencode.v31lift37.annotation.gtf.gz")
    parser.add_argument("--outf",default="gencode.v31.hg19.tss.bed")
    parser.add_argument("--flank",type=int,default=5000)
    parser.add_argument("--short_flank",type=int,default=200)
    return parser.parse_args()

def main():
    args=parse_args()
    data=pd.read_csv(args.gtf,header=None,skiprows=5,sep='\t')
    genes=data[data[2]=="transcript"]
    plus_strand_genes=genes[genes[6]=="+"]
    minus_strand_genes=genes[genes[6]=="-"]
    plus_strand_genes['tss']=plus_strand_genes[3]
    plus_strand_genes['start_tss_region']=plus_strand_genes['tss']-args.flank
    plus_strand_genes['end_tss_region']=plus_strand_genes['tss']+args.flank
    plus_strand_genes['short_start_tss_region']=plus_strand_genes['tss']-args.short_flank
    plus_strand_genes['short_end_tss_region']=plus_strand_genes['tss']+args.short_flank
    
    minus_strand_genes['tss']=minus_strand_genes[4]
    minus_strand_genes['start_tss_region']=minus_strand_genes['tss']-args.flank
    minus_strand_genes['end_tss_region']=minus_strand_genes['tss']+args.flank
    minus_strand_genes['short_start_tss_region']=minus_strand_genes['tss']-args.short_flank
    minus_strand_genes['short_end_tss_region']=minus_strand_genes['tss']+args.short_flank
    
    minus_subset=minus_strand_genes[[0,'start_tss_region','end_tss_region','short_start_tss_region','short_end_tss_region','tss',8]]
    plus_subset=plus_strand_genes[[0,'start_tss_region','end_tss_region','short_start_tss_region','short_end_tss_region','tss',8]]
    all_tss=pd.concat((minus_subset,plus_subset),axis=0)
    bad_pos=all_tss['start_tss_region']<0
    all_tss['start_tss_region'][bad_pos]=0
    all_tss=all_tss[all_tss[0].str.startswith('chr')]
    outf=open(args.outf,'w')
    outf_short=open(args.outf+".short",'w')#store tss+/-short_flank 
    for index,row in all_tss.iterrows():
        cur_chrom=row[0]
        cur_start_tss_region=row['start_tss_region']
        cur_end_tss_region=row['end_tss_region']
        cur_short_start_tss_region=row['short_start_tss_region']
        cur_short_end_tss_region=row['short_end_tss_region'] 
        cur_tss=row['tss' ]
        fields=[i.split() for i in row[8].replace('\"','').split(';')]
        gene_id=None
        gene_name=None 
        for field in fields:
            if len(field)<2:
                continue
            if field[0] == "gene_id":
                gene_id=field[1]
            elif field[0]=="gene_name":
                gene_name=field[1]
        outf.write(cur_chrom+'\t'+str(cur_start_tss_region)+'\t'+str(cur_end_tss_region)+'\t'+str(cur_tss)+'\t'+str(gene_id)+'\t'+gene_id.split('.')[0]+'\t'+str(gene_name)+'\n')
        outf_short.write(cur_chrom+'\t'+str(cur_short_start_tss_region)+'\t'+str(cur_short_end_tss_region)+'\t'+str(cur_tss)+'\t'+str(gene_id)+'\t'+gene_id.split('.')[0]+'\t'+str(gene_name)+'\n')
        
    
if __name__=="__main__":
    main()
    
