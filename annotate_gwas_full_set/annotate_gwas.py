import argparse
import pysam
import pybedtools
import pdb
import pandas as pd
from os import listdir
from os.path import isfile,join

def parse_args():
    parser=argparse.ArgumentParser(description="extract bed file with key summary stats & GC content info from GWAS summaries")
    parser.add_argument("--source_file")
    parser.add_argument("--chrom")
    parser.add_argument("--flank_for_gc",type=int,help="flank on one direction,i.e. 100 for +/-100 bp from SNP")
    parser.add_argument("--ref_fasta",default="/mnt/data/annotations/by_release/hg19.GRCh37/hg19.genome.fa")
    parser.add_argument("--tss_bed")
    parser.add_argument("--screen_metadata",default="screen_bed_files.txt")
    parser.add_argument("--screen_bed_dir")
    parser.add_argument("--outf")
    return parser.parse_args()

def get_gc(ref,chrom,startpos,flank):
    seq=ref.fetch(chrom,startpos-flank,startpos+flank).lower()
    seq_len=len(seq)
    c_fract=seq.count('c')/seq_len
    g_fract=seq.count('g')/seq_len
    return c_fract+g_fract

def get_screen_beds(screen_bed_dir):
    #attempt to load all bed files into memory
    screen_files=[pybedtools.BedTool('/'.join([screen_bed_dir,f])) for f in listdir(screen_bed_dir) if isfile(join(screen_bed_dir,f))]
    screen_file_names=[f.split('.')[0] for f in listdir(screen_bed_dir) if isfile(join(screen_bed_dir,f))]
    print("loaded all screen files")
    return screen_files,screen_file_names


def main():
    args=parse_args()
    outf=open(args.outf,'w')
    outf.write('Name\tChrom\tPos1\tPos2\tAllele1\tAllele2\tFreq1\tP-value\tGC%\tNearestGene\tDistTSS\tScreenAccessions\tScreenTissue_State\n')
    ref=pysam.FastaFile(args.ref_fasta)
    data=open(args.source_file,'r').read().strip().split('\n')
    print('read in chrom') 
    chrom=args.chrom
    tss_bed=pybedtools.BedTool(args.tss_bed)
    print('read in tss bed') 
    screen_metadata=pd.read_csv(args.screen_metadata,index_col=0,header=0,sep='\t')
    screen_beds,screen_bed_names=get_screen_beds(args.screen_bed_dir)
    print("got screen metadata and bed") 
    outf.write("\n")
    c=0
    tmp_hash=dict()
    regions=[] 
    for line in data[1::]:
        c+=1
        if c%10000==0:
            print(c)
        tokens=line.split()
        name=tokens[0]
        startpos=int(tokens[-1])
        endpos=startpos+1
        allele1=tokens[1]
        allele2=tokens[2]
        freq=tokens[3]
        pval=tokens[-3]
        #get the gc fraction
        gc_fract=get_gc(ref,chrom,startpos,args.flank_for_gc)
        tmp_hash[(chrom,str(startpos),str(endpos))]=[[],[],name,chrom,str(startpos),str(endpos),allele1,allele2,freq,pval,str(gc_fract)]
        regions.append(chrom+'\t'+str(startpos)+'\t'+str(endpos))

    #merge the SNP's into a bed file 
    region_bed=pybedtools.BedTool('\n'.join(regions),from_string=True)
    print("generated merged bed file from GWAS hits")
    #get the nearest TSS
    tss_intersection=region_bed.closest(tss_bed,d=True)
    print('got tss intersections')
    for cur_intersection in tss_intersection:
        chrom=cur_intersection[0]
        startpos=cur_intersection[1]
        endpos=cur_intersection[2]
        closest_gene=cur_intersection[-3]
        dist_to_nearest_tss=cur_intersection[-1]
        tmp_hash[(chrom,startpos,endpos)].append(closest_gene)
        tmp_hash[(chrom,startpos,endpos)].append(str(dist_to_nearest_tss))
    print("annotated TSS intersections")

    #annotate with SCREEN regions
    print('annotating w/ screen')
    for i in range(len(screen_beds)):
        screen_intersection=region_bed.intersect(screen_beds[i])
        cur_accession=screen_bed_names[i]
        cur_tissue=screen_metadata.loc[cur_accession]['Tissue']
        cur_category=screen_metadata.loc[cur_accession]['Category']
        cur_tissue_category='_'.join([cur_tissue,cur_category])
        for entry in screen_intersection:
            chrom=entry[0]
            startpos=entry[1]
            endpos=entry[2]
            tmp_hash[(chrom,startpos,endpos)][0].append(cur_accession)
            tmp_hash[(chrom,startpos,endpos)][1].append(cur_tissue_category)
    #write the annotation for the SNP
    print('writing output')
    for key in tmp_hash:
        value=tmp_hash[key]
        value[0]=','.join(value[0])
        value[1]=','.join(value[1])
        outf.write('\t'.join(value[2::])+'\t'+value[0]+'\t'+value[1]+'\n')
        
                               
if __name__=="__main__":
    main()

