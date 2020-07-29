import pysam
score_dict={}
prefix_ref="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores/pred_ref"
prefix_alt="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores/pred_alt"
datasets=["colo205","hct116","sw480","dnase_c","dnase_v"]
ref_fasta=pysam.FastaFile("/mnt/data/male.hg19.fa")
for dataset in datasets:
    for split in range(0,10):
        pred_ref=open(prefix_ref+"/"+"ref.pred."+str(split)+"."+dataset+".txt",'r').read().strip().split('\n')
        pred_alt=open(prefix_alt+"/"+"alt.pred."+str(split)+"."+dataset+".txt",'r').read().strip().split('\n')
        print("loaded preds:"+str(split)+"."+dataset)
        for line in pred_ref:
            tokens=line.split('\t')
            snp=tokens[0]
            chrom='chr'+snp.split(':')[0]
            pos=int(snp.split(':')[1].split('_')[0])-1
            ref_fasta_allele=ref_fasta.fetch(chrom,pos,pos+1).lower()
            print(ref_fasta_allele)
            ref_snp_allele=snp.split('_')[-1].split('/')[0].lower()
            svm_score=float(tokens[1])
            if snp not in score_dict:
                score_dict[snp]={}
            if dataset not in score_dict[snp]:
                score_dict[snp][dataset]={}
            if ref_fasta_allele == ref_snp_allele:
                score_dict[snp][dataset]['ref']=svm_score
            else:
                score_dict[snp][dataset]['alt']=svm_score 
        for line in pred_alt:
            tokens=line.split('\t')
            snp=tokens[0]
            chrom='chr'+snp.split(':')[0]
            pos=int(snp.split(':')[1].split('_')[0])-1
            ref_fasta_allele=ref_fasta.fetch(chrom,pos,pos+1).lower()
            print(ref_fasta_allele)
            ref_snp_allele=snp.split('_')[-1].split('/')[0].lower()            
            svm_score=float(tokens[1])
            if snp not in score_dict:
                score_dict[snp]={}
            if dataset not in score_dict[snp]:
                score_dict[snp][dataset]={}
            if ref_fasta_allele==ref_snp_allele:
                score_dict[snp][dataset]['alt']=svm_score
            else:
                score_dict[snp][dataset]['ref']=svm_score
                
outf=open('gecco.snps.in.peaks.svm.scores.txt','w')
outf.write('SNP')
for dataset in datasets:
    outf.write('\t'+dataset+".REF"+'\t'+dataset+".ALT"+'\t'+dataset+".ALT-REF")
outf.write('\n')
for snp in score_dict:
    outf.write(snp) 
    for dataset in datasets:
        cur_ref=score_dict[snp][dataset]['ref']
        cur_alt=score_dict[snp][dataset]['alt']
        cur_delta=cur_alt-cur_ref
        outf.write('\t'+str(round(cur_ref,3))+'\t'+str(round(cur_alt,3))+'\t'+str(round(cur_delta,3)))
    outf.write('\n')
outf.close()

            
