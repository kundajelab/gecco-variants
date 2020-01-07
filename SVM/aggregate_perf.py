import argparse
import pandas as pd

def parse_args():
    parser=argparse.ArgumentParser()
    parser.add_argument("--svm_perf",nargs="+")
    parser.add_argument("--dl_perf",nargs="+")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    perf_dict=dict()
    #print(args.svm_perf)
    #print(args.dl_perf)
    for svm_perf_entry in args.svm_perf:
        fname_tokens=svm_perf_entry.split('.')
        task=fname_tokens[1]
        fold=fname_tokens[2] 
        data=open(svm_perf_entry,'r').read().strip().split('\n')
        if task not in perf_dict:
            perf_dict[task]=dict()
        if fold not in perf_dict[task]:
            perf_dict[task][fold]=dict()
        for line in data[1::]:
            tokens=line.split('\t')
            metric=tokens[0]
            try:
                val=tokens[1]
                if metric not in perf_dict[task][fold]:
                    perf_dict[task][fold][metric]=dict()
                perf_dict[task][fold][metric]['SVM']=val
            except:
                print(tokens) 
    for dl_perf_entry in args.dl_perf:
        fname_tokens=dl_perf_entry.split('.')
        task=fname_tokens[1]
        fold=fname_tokens[2] 
        data=open(dl_perf_entry,'r').read().strip().split('\n')
        for line in data[1::]:
            tokens=line.split('\t')
            metric=tokens[0]
            val=tokens[1]
            if metric not in perf_dict[task][fold]:
                perf_dict[task][fold][metric]=dict()
            perf_dict[task][fold][metric]['NN']=val
    #aggregate outputf
    outf=open(args.outf,'w')
    outf.write('Task\tFold\tMetric\tModel\tVal\n')
    for task in perf_dict:
        for fold in perf_dict[task]:
            for metric in perf_dict[task][fold]:
                for model in perf_dict[task][fold][metric]:
                    cur_val=perf_dict[task][fold][metric][model]
                    outf.write(task+'\t'+fold+'\t'+metric+'\t'+model+'\t'+cur_val+'\n')
    outf.close()
    
if __name__=="__main__":
    main()
    
    
