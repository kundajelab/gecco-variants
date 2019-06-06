import json 
import argparse 
def parse_args(): 
    parser=argparse.ArgumentParser(description="generate pval & fc bigwig tracks")
    parser.add_argument("--pval_bigwigs")
    parser.add_argument("--fc_bigwigs") 
    parser.add_argument("--hammocks") 
    parser.add_argument("--sample_index",type=int)
    parser.add_argument("--outf_fc_bigwig") 
    parser.add_argument("--outf_pval_bigwig")
    parser.add_argument("--mitra_prefix",default="http://mitra.stanford.edu/kundaje/projects/GECCO/") 
    parser.add_argument("--prefix_to_drop_for_oak",default="/oak/stanford/groups/akundaje/projects/GECCO/")
 
    return parser.parse_args() 
def main(): 
    args=parse_args() 
    sample_to_files=dict() 
    pval_bigwigs=open(args.pval_bigwigs,'r').read().strip().split('\n') 
    fc_bigwigs=open(args.fc_bigwigs,'r').read().strip().split('\n') 
    hammocks=open(args.hammocks,'r').read().strip().split('\n') 
    num_samples=len(hammocks)
    fc_bigwig_json=[] 
    pval_bigwig_json=[] 

    for i in range(num_samples): 
        fc_fname=fc_bigwigs[i]
        fc_sample=fc_fname.split('/')[args.sample_index]

        pval_fname=pval_bigwigs[i]
        pval_sample=pval_fname.split('/')[args.sample_index]

        hammock_fname=hammocks[i] 
        hammock_sample=hammock_fname.split('/')[args.sample_index] 
        assert fc_sample==pval_sample 
        assert pval_sample==hammock_sample
        assert fc_sample==hammock_sample
        #all samples the same
        sample=fc_sample
        print(sample) 


        fc_bigwig_dict={"type":"bigwig",
                        "url":fc_fname.replace(args.prefix_to_drop_for_oak,args.mitra_prefix).replace('.json','.html'),
                        "mode":1,
                        "name":",".join([sample,"FC"]),
                        "qtc": {"anglescale":1,
                                "pr":255,
                                "pg":71,
                                "pb":20,
                                "nr":255,
                                "ng":0,
                                "nb":0,
                                "pth":"rgb(0,0,178)",
                                "nth":"#800000",
                                "thtype":1,
                                "thmin":0,
                                "thmax":25,
                                "thpercentile":90,
                                "height":50,
                                "summeth":1}}
        pval_bigwig_dict={"type":"bigwig",
                        "url":pval_fname.replace(args.prefix_to_drop_for_oak,args.mitra_prefix).replace('.json','.html'),
                        "mode":1,
                        "name":",".join([sample,"PVAL"]),
                        "qtc": {"anglescale":1,
                                "pr":255,
                                "pg":71,
                                "pb":20,
                                "nr":255,
                                "ng":0,
                                "nb":0,
                                "pth":"rgb(0,0,178)",
                                "nth":"#800000",
                                "thtype":1,
                                "thmin":0,
                                "thmax":25,
                                "thpercentile":90,
                                "height":50,
                                "summeth":1}}
        hammock_dict={"type":"hammock",
                      "url":hammock_fname.replace(args.prefix_to_drop_for_oak,args.mitra_prefix).replace('.json','.html'),
                      "mode":"full",
                      "name":",".join([sample,"HAMMOCK"])}
        fc_bigwig_json.append(fc_bigwig_dict)
        fc_bigwig_json.append(hammock_dict)
        pval_bigwig_json.append(pval_bigwig_dict)
        pval_bigwig_json.append(hammock_dict)

    with open(args.outf_fc_bigwig, 'w') as outfile:  
        json.dump(fc_bigwig_json, outfile)
    with open(args.outf_pval_bigwig,'w') as outfile: 
        json.dump(pval_bigwig_json,outfile) 
    
if __name__=="__main__": 
    main() 
