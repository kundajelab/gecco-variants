import pysam
score_dict={}
prefix_ref="/oak/stanford/groups/akundaje/projects/GECCO/alcohol/pred_ref"
prefix_alt="/oak/stanford/groups/akundaje/projects/GECCO/alcohol/pred_alt"
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
            svm_score=float(tokens[1])
            if snp not in score_dict:
                score_dict[snp]={}
            if dataset not in score_dict[snp]:
                score_dict[snp][dataset]={}
            score_dict[snp][dataset]['ref']=svm_score
        for line in pred_alt:
            tokens=line.split('\t')
            snp=tokens[0]
            svm_score=float(tokens[1])
            if snp not in score_dict:
                score_dict[snp]={}
            if dataset not in score_dict[snp]:
                score_dict[snp][dataset]={}
            score_dict[snp][dataset]['alt']=svm_score
                            
outf=open('gecco.snps.alcohol.svm.scores.txt','w')
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

            
