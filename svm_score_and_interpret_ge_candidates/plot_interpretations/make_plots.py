import argparse
import pdb
import pandas as pd
import numpy as np
import logomaker
import pysam
import matplotlib
from matplotlib import pyplot as plt
ltrdict = {'a':[1,0,0,0],
           'c':[0,1,0,0],
           'g':[0,0,1,0],
           't':[0,0,0,1],
           'n':[0,0,0,0],
           'A':[1,0,0,0],
           'C':[0,1,0,0],
           'G':[0,0,1,0],
           'T':[0,0,0,1],
           'N':[0,0,0,0]}

def one_hot_encode(seq):
        return np.array([ltrdict.get(x,[0,0,0,0]) for x in seq])
    
def parse_args():
    parser=argparse.ArgumentParser()
    parser.add_argument("--ref_gkmexplain_dir")
    parser.add_argument("--alt_gkmexplain_dir")
    parser.add_argument("--flank",type=int,default=500)
    parser.add_argument("--out_dir")
    parser.add_argument("--snp_pos",type=int,default=500)
    parser.add_argument("--tasks",nargs="+")
    parser.add_argument("--splits",type=int,nargs="+")
    parser.add_argument("--rerun",default=None)
    parser.add_argument("--rerun_index_start",type=int,default=None)
    parser.add_argument("--rerun_index_end",type=int,default=None) 
    return parser.parse_args()

def main():
    args=parse_args()
    rerun=open(args.rerun,'r').read().strip().split('\n')
    if args.rerun_index_start is None:
        rerun_index_start=0
    else:
        rerun_index_start=args.rerun_index_start
    if args.rerun_index_end is None:
        rerun_index_end=len(rerun)
    else:
        rerun_index_end=args.rerun_index_end
    rerun=rerun[rerun_index_start:rerun_index_end]    
    rerun_dict={}
    for line in rerun:
        rerun_dict[line]=1
            
    score_dict={}
    for task in args.tasks:
        for split in args.splits:
            refs=open(args.ref_gkmexplain_dir+'/'+'gkmexplain'+'.'+task+'.'+str(split)+'.txt','r').read().strip().split('\n')
            alts=open(args.alt_gkmexplain_dir+'/'+'gkmexplain'+'.'+task+'.'+str(split)+'.txt','r').read().strip().split('\n')
            for line in refs:
                tokens=line.split('\t')
                snp=tokens[0]
                if snp not in rerun_dict:
                        continue
                try:
                        scores= np.asarray([[float(j) for j in i.split(',')] for i in tokens[-1].strip(';').split(';')])
                except:
                        #print(tokens[-1])
                        #pdb.set_trace() 
                        continue 
                if snp not in score_dict:
                    score_dict[snp]={}
                    #get the ref seq
                if task not in score_dict[snp]:
                    score_dict[snp][task]={}
                score_dict[snp][task]['ref']=scores
            for line in alts:
                tokens=line.split('\t')
                snp=tokens[0]
                if snp not in rerun_dict:
                        continue
                try:
                        scores= np.asarray([[float(j) for j in i.split(',')] for i in tokens[-1].strip(';').split(';')])
                except:
                        #print(tokens[-1])
                        continue
                if snp not in score_dict:
                    score_dict[snp]={}
                if task not in score_dict[snp]:
                    score_dict[snp][task]={}
                score_dict[snp][task]['alt']=scores
        
    #make plots!
    print("plotting!")
    for snp in score_dict:
        try:
            f,axes=plt.subplots(nrows=2,ncols=5,dpi=200,figsize=(45,5))
            plots=[]
            cur_index=0
            for task in args.tasks:
                toplot_seq=pd.DataFrame(score_dict[snp][task]['ref'],columns=['A','C','G','T'])                
                cur_logo=logomaker.Logo(toplot_seq,font_name='Arial Rounded MT Bold', color_scheme='classic',ax=axes[0,cur_index])
                # style using Logo methods
                cur_logo.style_spines(visible=True)
                cur_logo.style_spines(spines=['left', 'bottom'], visible=True)
                cur_logo.style_xticks(rotation=90, fmt='%d', anchor=0, spacing=25)
                cur_logo.ax.axvline(args.flank, color='k', linewidth=1, linestyle=':')

                # style using Axes methods
                cur_logo.ax.set_ylabel(task)
                axes[0,cur_index].set_xlim(400,600)

                toplot_seq=pd.DataFrame(score_dict[snp][task]['alt'],columns=['A','C','G','T'])
                #pdb.set_trace()
                cur_logo=logomaker.Logo(toplot_seq,font_name='Arial Rounded MT Bold', color_scheme='classic',ax=axes[1,cur_index])
                # style using Logo methods
                cur_logo.style_spines(visible=True)
                cur_logo.style_spines(spines=['left', 'bottom'], visible=True)
                cur_logo.style_xticks(rotation=90, fmt='%d', anchor=0, spacing=25)
                cur_logo.ax.axvline(args.flank, color='k', linewidth=1, linestyle=':')
                # style using Axes methods
                cur_logo.ax.set_ylabel(task, labelpad=-1)
                axes[1,cur_index].set_xlim(400,600)
                cur_index+=1
            plt.suptitle(snp)
            plt.subplots_adjust(hspace=0.4)
            plt.savefig(args.out_dir+"/"+snp+".png",type='png',bbox_inches='tight',pad_inches = 0, dpi = 200)
        except:
                print(snp)
                
if __name__=="__main__":
    main()
    
