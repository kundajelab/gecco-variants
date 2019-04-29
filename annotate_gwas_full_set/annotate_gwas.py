import argparse
import pickle
import pysam
import pybedtools
import pdb
import pandas as pd
from os import listdir
from os.path import isfile,join
from itertools import chain

def parse_args():
    parser=argparse.ArgumentParser(description="extract bed file with key summary stats & GC content info from GWAS summaries")
    parser.add_argument("--source_file")
    parser.add_argument("--chrom")
    parser.add_argument("--flank_for_gc",type=int,help="flank on one direction,i.e. 100 for +/-100 bp from SNP")
    parser.add_argument("--ref_fasta",default="/mnt/data/annotations/by_release/hg19.GRCh37/hg19.genome.fa")
    parser.add_argument("--tss_bed")
    parser.add_argument("--outf")
    parser.add_argument("--screen_pickle",default="/oak/stanford/groups/akundaje/refs/ENCODE/screen/assembly_state_tissue_annotations.p")
    parser.add_argument("--screen_regions",default="/oak/stanford/groups/akundaje/refs/ENCODE/screen/regions.bed")
    parser.add_argument("--assembly",default="hg19")
    parser.add_argument("--encode_dnase_file",default="ENCODE.dnase.bed")
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
    outf.write('Name\tChrom\tPos1\tPos2\tAllele1\tAllele2\tFreq1\tP-value\tGC%\tNearestGene\tDistTSS\tDistDNASE\tPLS\tELS\tCTCF\tDNase\n')
    ref=pysam.FastaFile(args.ref_fasta)
    data=open(args.source_file,'r').read().strip().split('\n')
    print('read in chrom') 
    chrom=args.chrom
    tss_bed=pybedtools.BedTool(args.tss_bed)
    print('read in tss bed') 
    encode_dnase=pybedtools.BedTool(args.encode_dnase_file) 
    print('read in encode dnase') 
    screen_regions=pybedtools.BedTool(args.screen_regions)
    print("read in screen regions")
    screen_annotations=pickle.load(open(args.screen_pickle,'rb'))
    print("got screen annotations") 
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
        #PLS, ELS, CTCF, DNase, named entries, ClosesGene,TSS, TSS dist 
        tmp_hash[(chrom,str(startpos),str(endpos))]=['',
                                                     '',
                                                     '',
                                                     '',
                                                     name,
                                                     chrom,
                                                     str(startpos),
                                                     str(endpos),
                                                     allele1,
                                                     allele2,
                                                     freq,
                                                     pval,
                                                     str(gc_fract),
                                                     None,
                                                     None,
                                                     None]
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
        #avoid duplicate entries -- don't store as list 
        tmp_hash[(chrom,startpos,endpos)][-3]=closest_gene
        tmp_hash[(chrom,startpos,endpos)][-2]=str(dist_to_nearest_tss)
    print("annotated TSS intersections")
    dnase_intersection=region_bed.closest(encode_dnase,d=True)
    print('got encode dnase intersection') 
    for cur_intersection in dnase_intersection: 
        chrom=cur_intersection[0] 
        startpos=cur_intersection[1] 
        endpos=cur_intersection[2] 
        dist_to_nearest_dnase_peak=cur_intersection[-1] 
        tmp_hash[(chrom,startpos,endpos)][-1]=str(dist_to_nearest_dnase_peak)

    #annotate with SCREEN regions
    print('annotating w/ screen')
    screen_intersection=region_bed.intersect(screen_regions,wo=True)
    for entry in screen_intersection: 
        snp_chrom=str(entry[0]) 
        snp_startpos=str(entry[1]) 
        snp_endpos=str(entry[2]) 
        region_chrom=entry[-4] 
        region_startpos=entry[-3] 
        region_endpos=entry[-2] 
        try:
            annotation_data=screen_annotations[tuple([region_chrom,int(region_startpos),int(region_endpos)])]
            if args.assembly in annotation_data: 
                #check by state 
                if 'PLS' in annotation_data[args.assembly]: 
                    values=[str(i).split(',') for i in annotation_data[args.assembly]['PLS']]
                    merged=set(chain.from_iterable(values))
                    if (len(merged) > 1): 
                        merged.remove('nan')
                    tmp_hash[(snp_chrom,snp_startpos,snp_endpos)][0]=';'.join(merged)
                if 'ELS' in annotation_data[args.assembly]: 
                    values=[str(i).split(',') for i in annotation_data[args.assembly]['ELS']]
                    merged=set(chain.from_iterable(values))
                    if (len(merged)>1): 
                        merged.remove('nan')
                    tmp_hash[(snp_chrom,snp_startpos,snp_endpos)][1]=';'.join(merged)
                if 'CTCF' in annotation_data[args.assembly]: 
                    values=[str(i).split(',') for i in annotation_data[args.assembly]['CTCF']]
                    merged=set(chain.from_iterable(values))
                    if (len(merged)>1): 
                        merged.remove('nan')
                    tmp_hash[(snp_chrom,snp_startpos,snp_endpos)][2]=';'.join(merged)
                if 'DNase' in annotation_data[args.assembly]: 
                    values=[str(i).split(',') for i in annotation_data[args.assembly]['DNase']]
                    merged=set(chain.from_iterable(values))
                    if (len(merged)>1): 
                        merged.remove('nan')
                    tmp_hash[(snp_chrom,snp_startpos,snp_endpos)][3]=';'.join(merged)
        except:
            continue
    #write the annotation for the SNP
    print('writing output')
    for key in tmp_hash:
        value=tmp_hash[key]
        outf.write('\t'.join(value[4::])+'\t'+'\t'.join(value[0:4])+'\n')
        
                               
if __name__=="__main__":
    main()

