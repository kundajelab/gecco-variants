import sys
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="aggregate SVM predictions for alt & ref as well as gkmexplain scores ")
    parser.add_argument("--preds_ref_files",nargs='+')
    parser.add_argument("--preds_alt_files",nargs='+')
    parser.add_argument("--preds_ref_names",nargs='+')
    parser.add_argument("--preds_alt_names",nargs='+')
    parser.add_argument("--outf") 
    return parser.parse_args()

def main():
    args=parse_args()
    num_datasets=len(args.preds_ref_files)
    assert len(args.preds_ref_files)==len(args.preds_alt_files)
    score_dict={}
    for i in range(num_datasets): 
        pred_ref=open(args.preds_ref_files[i],'r').read().strip().split('\n')
        pred_alt=open(args.preds_alt_files[i],'r').read().strip().split('\n')
        preds_ref_name=args.preds_ref_names[i]
        preds_alt_name=args.preds_alt_names[i]
        
        for line in pred_ref:
            tokens=line.split('\t')
            snp=tokens[0]
            svm_score=float(tokens[1])
            
            if snp not in score_dict:
                score_dict[snp]={}
            score_dict[snp][preds_ref_name]=svm_score 
        for line in pred_alt:
            tokens=line.split('\t')
            snp=tokens[0]
            svm_score=float(tokens[1])
            if snp not in score_dict:
                score_dict[snp]={}
            score_dict[snp][preds_alt_name]=svm_score

    outf=open(args.outf,'w')
    outf.write('SNP')
    for i in range(num_datasets):
        outf.write('\t'+args.preds_ref_names[i]+'\t'+args.preds_alt_names[i]+'\t'+args.preds_alt_names[i]+'-REF')
    outf.write('\n')
    for snp in score_dict:
        outf.write(snp) 
        for i in range(num_datasets):
            preds_ref_name=args.preds_ref_names[i]
            preds_alt_name=args.preds_alt_names[i]
            cur_ref=score_dict[snp][preds_ref_name]
            cur_alt=score_dict[snp][preds_alt_name]
            cur_delta=cur_alt-cur_ref
            outf.write('\t'+str(round(cur_ref,3))+'\t'+str(round(cur_alt,3))+'\t'+str(round(cur_delta,3)))
        outf.write('\n')
    outf.close()


if __name__=="__main__":
    main()
    
