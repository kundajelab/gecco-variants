import pysam
import pdb
refseq="/srv/scratch/annashch/deeplearning/form_inputs/code/hg19.genome.fa"
ref=pysam.FastaFile(refseq)
cred_set=open("99percent_cred_set.bed",'r').read().strip().split('\n')
outf=open('gc.percent.200bp.bed','w')
for line in cred_set:
    tokens=line.split('\t')
    chrom=tokens[0]
    startpos=int(tokens[2])-100
    endpos=int(tokens[2])+100
    seq=ref.fetch(chrom,startpos,endpos).lower()
    seq_len=len(seq)
    c_fract=seq.count('c')/seq_len
    g_fract=seq.count('g')/seq_len
    t_fract=seq.count('t')/seq_len
    a_fract=seq.count('a')/seq_len
    gc_fract=c_fract+g_fract
    outf.write(line+'\t'+str(a_fract)+'\t'+str(c_fract)+'\t'+str(g_fract)+'\t'+str(t_fract)+'\t'+str(gc_fract)+'\n')
    
    

