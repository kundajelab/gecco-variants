import numpy as np
import pickle

#for each variant, identify the tag snp and whether or not the variant was identified via GWAS or CRISPR
snp_dict=dict()
from os import listdir
from os.path import isfile, join
mypath="/srv/scratch/annashch/gecco/colorectal_cancer_gwas_hits_for_anna/credible_sets"
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
for f in onlyfiles:
    if f.endswith('.tsv'):
        data=open(mypath+'/'+f,'r').read().strip().split('\n')
        #get the tagged snp
        tag_parts=f.split('-')
        tag_chrom=tag_parts[0]
        tag_pos=tag_parts[1]
        tag=tuple([tag_chrom,tag_pos])
        for line in data[1::]:
            var=line.split('\t')[0]
            var=var.split(':')
            chrom='chr'+var[0]
            pos_data=var[1].split('_')
            pos=pos_data[0]
            snp_dict[tuple([chrom,pos])]=[tag,'gwas']
data=open('/srv/scratch/annashch/gecco/CRC_results.tsv','r').read().strip().split('\n')
for line in data[1::]:
    tokens=line.split('\t')
    chrom=tokens[0]
    pos=tokens[1]
    snp_dict[tuple([chrom,pos])]=[tuple([chrom,pos]),'crispr']            
            
#load the variant list
variants=open('variants.bed','r').read().strip().split('\n')[1::]#cut off header 
num_vars=len(variants)#account for header 

#load the single task predictions

num_tasks=30
pred_seq=np.zeros((num_vars,num_tasks))
pred_snp=np.zeros((num_vars,num_tasks))
pred_mask=np.zeros((num_vars,num_tasks))
for i in range(num_tasks):
    with open('/srv/scratch/annashch/deeplearning/gecco/single.'+str(i)+'.vars','rb') as handle:
        predictions=pickle.load(handle)
        pred_seq[:,i]=np.squeeze(predictions[0])
        pred_snp[:,i]=np.squeeze(predictions[1])
        pred_mask[:,i]=np.squeeze(predictions[2])
#average
pred_seq=np.mean(pred_seq,axis=1)
pred_snp=np.mean(pred_snp,axis=1)
pred_mask=np.mean(pred_mask,axis=1)

#save to heatmap input
outf=open('summary.ism.single_task','w')
outf.write('Chrom\tPos\tGroup\tSource\tPredSeq\tPredSnp\tPredMask\n')
for v_index in range(num_vars):
    cur_var=tuple(variants[v_index].split('\t')[0:2])
    cur_pred_seq=pred_seq[v_index]
    cur_pred_snp=pred_snp[v_index]
    cur_pred_mask=pred_mask[v_index]
    metadata=snp_dict[cur_var]
    outf.write(cur_var[0]+'\t'+cur_var[1]+'\t'+str(metadata[0])+'\t'+metadata[1]+'\t'+str(cur_pred_seq)+'\t'+str(cur_pred_snp)+'\t'+str(cur_pred_mask)+'\n')
    
