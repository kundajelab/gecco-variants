import argparse
import pandas as pd
import numpy as np 
from scipy.stats import *
from kerasAC.util import *
import pickle
import pdb

def parse_args():
    parser=argparse.ArgumentParser(description="aggregate gkmexplain scores across folds, compute significance")
    parser.add_argument("--ref_fold_scores",nargs="+",help="fold-specific scores for reference allele, these are averaged")
    parser.add_argument("--alt_fold_scores",nargs="+",help="fold-specific scores for alternate alelle, these are averaged")
    parser.add_argument("--start_base_snp_score",type=int,default=475)
    parser.add_argument("--end_base_snp_score",type=int,default=525)    
    parser.add_argument("--ref_seqs")
    parser.add_argument("--alt_seqs") 
    parser.add_argument("--outf")
    return parser.parse_args()

def get_mean_scores_and_preds(fold_scores):
    mean_gkmexplain={}
    mean_pred={}
    #aggregate reference allele predictions and gkmexplain scores
    for fold_score in fold_scores:
        print(fold_score)
        scores=pd.read_csv(fold_score,sep='\t',header=None)
        for index,row in scores.iterrows():
            snp_label=tuple(row[0].split('_')[0:-1])
            snp_pred=row[1]
            gkm_scores=np.asarray([[float(j) for j in i.split(',')] for i in row[2].split(';')])
            #print(gkm_scores.shape)
            if snp_label not in mean_gkmexplain:
                mean_gkmexplain[snp_label]=[gkm_scores,1]
                mean_pred[snp_label]=[snp_pred,1]
            else:
                try:
                    mean_gkmexplain[snp_label][0]+=gkm_scores
                except:
                    pdb.set_trace() 
                mean_gkmexplain[snp_label][1]+=1
                mean_pred[snp_label][0]+=snp_pred
                mean_pred[snp_label][1]+=1
    #get mean gkmexplain and prediction score across folds
    print('averaging!')
    for snp_label in mean_gkmexplain:
        mean_gkmexplain[snp_label][0]=mean_gkmexplain[snp_label][0]/mean_gkmexplain[snp_label][1]
        mean_pred[snp_label][0]=mean_pred[snp_label][0]/mean_pred[snp_label][1]
    return mean_gkmexplain,mean_pred

def get_delta_track(mean_ref_gkmexplain,mean_alt_gkmexplain):
    deltas={}
    for snp_label in list(mean_ref_gkmexplain.keys()):
        deltas[snp_label]=mean_alt_gkmexplain[snp_label][0]-mean_ref_gkmexplain[snp_label][0]
    return deltas 
        
def one_hot_encode_wrapper(seq_file):
    data=open(seq_file,'r').read().strip().split('>')[1::]
    snp_labels=[]
    seqs=[]
    encoded={}
    for line in data:
        tokens=line.split('\n') 
        snp_label=tokens[0]
        seq=tokens[1]
        snp_labels.append(snp_label)
        seqs.append(seq)
    encoded_seqs=one_hot_encode(seqs)
    for i in range(len(snp_labels)):
        encoded[snp_labels[i]]=encoded_seqs[i]
    return encoded

def get_snp_importance_scores(mean_ref_gkmexplain,mean_alt_gkmexplain,args):
    scores_ref={}
    scores_alt={}
    scores_diff={}
    for snp_label in list(mean_ref_gkmexplain.keys()):
        ref_scores=mean_ref_gkmexplain[snp_label][0][args.start_base_snp_score:args.end_base_snp_score]
        alt_scores=mean_alt_gkmexplain[snp_label][0][args.start_base_snp_score:args.end_base_snp_score]
        ref_sum_score=np.sum(np.array([np.sum(j) for j in ref_scores]))
        alt_sum_score=np.sum(np.array([np.sum(j) for j in alt_scores]))
        scores_ref[snp_label]=ref_sum_score
        scores_alt[snp_label]=alt_sum_score
        scores_diff[snp_label]=alt_sum_score-ref_sum_score
    return scores_ref, scores_alt, scores_diff

def get_pval(distribution_params,snp_scores):
    t_shape=distribution_params[0]
    t_mean=distribution_params[1]
    t_stdev=distribution_params[2]
    pval_dict=dict()
    for snp in snp_scores:
        cur_score=snp_scores[snp]
        pval_dict[snp]=2*min(t.cdf(cur_score,t_shape,t_mean,t_stdev),1-t.cdf(cur_score, t_shape, t_mean, t_stdev))
    return pval_dict 
 

def get_distribution(snp_importance_scores):
    flipped_scores=[-1*score for score in snp_importance_scores]
    all_scores=snp_importance_scores+flipped_scores
    print(len(all_scores))
    t_shape, t_mean, t_stdev = t.fit(all_scores)
    print('Shape:', '\t', t_shape)
    print('Mean:', '\t', t_mean)
    print('Stdev:', '\t', t_stdev)
    print(stats.kstest(all_scores, 't', args=[t_shape, t_mean, t_stdev]))
    return t_shape, t_mean, t_stdev

def main():
    args=parse_args()
    #average gkmexplain scores and svm predictions across the folds for the reference alleles 
    mean_ref_gkmexplain,mean_ref_pred=get_mean_scores_and_preds(args.ref_fold_scores)

    #and for the alternate alleles
    mean_alt_gkmexplain,mean_alt_pred=get_mean_scores_and_preds(args.alt_fold_scores)

    print("getting delta track")
    #get the delta track for each snp
    delta_track=get_delta_track(mean_ref_gkmexplain,mean_alt_gkmexplain)

    print("getting one-hot-encoded inputs")
    #get one-hot-encoded ref and alt sequences
    ref_seqs=one_hot_encode_wrapper(args.ref_seqs)
    alt_seqs=one_hot_encode_wrapper(args.alt_seqs)

    print("pickling mean gkmexplain ref, alt, delta scores as well as one-hot-encoded refs")
    #store mean_ref_track, mean_alt_track, delta_track, and one-hot-encoded sequence --> we will plot these
    intermediate_outputs=[mean_ref_gkmexplain, mean_alt_gkmexplain, delta_track, ref_seqs, alt_seqs]
    pickle.dump(intermediate_outputs,open(args.outf+".intermediate.p",'wb'))

    print("getting aggregate snp scores")
    #get snp score by summing average importance scores of central 50 bp , and subtracting ref from alt
    scores_ref, scores_alt, scores_diff =get_snp_importance_scores(mean_ref_gkmexplain,mean_alt_gkmexplain,args)
    
    #generate t distribution of scores
    print("fitting ref & alt SNP scores to t distribution:")
    distribution_scores=get_distribution(list(scores_ref.values())+list(scores_alt.values()))
    print("fitting diff SNP scores to t distribution:") 
    distribution_diff=get_distribution(list(scores_diff.values()))

    print("calculating pvalues")
    #calculate p-value for each SNP
    pval_ref=get_pval(distribution_scores,scores_ref)
    pval_alt=get_pval(distribution_scores,scores_alt)
    pval_diff=get_pval(distribution_scores,scores_diff)

    print("writing output file")
    #generate output file 
    outf=open(args.outf,'w')
    outf.write('CHROM\tPOS0\tREF\tALT\tRSID\tSVM_REF\tSVM_ALT\tSCORE_REF\tSCORE_ALT\tSCORE_ALT_MINUS_REF\tP_REF\tP_ALT\tP_DELTA\n')
    all_snps=list(pval_diff.keys())
    for snp in all_snps:
        out_string=[str(i) for i in list(snp)]
        out_string.append(str(round(mean_ref_pred[snp][0],3)))
        out_string.append(str(round(mean_alt_pred[snp][0],3)))
        out_string.append(str(round(scores_ref[snp],3)))
        out_string.append(str(round(scores_alt[snp],3)))
        out_string.append(str(round(scores_diff[snp],3)))
        out_string.append(str(round(pval_ref[snp],3)))
        out_string.append(str(round(pval_alt[snp],3)))
        out_string.append(str(round(pval_diff[snp],3)))        
        out_string='\t'.join(out_string)
        outf.write(out_string+'\n')
    outf.close()
    
if __name__=="__main__":
    main()
    
