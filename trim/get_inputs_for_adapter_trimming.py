import argparse 
import json 

def parse_args(): 
    parser=argparse.ArgumentParser(description="generate inputs for trimommatic script") 
    parser.add_argument("--samples",default="samples.txt") 
    parser.add_argument("--base_dir",default="/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/output_hg19") 
    parser.add_argument("--outf",default="sbatch.trim_adapters.sh")
    return parser.parse_args() 
def main(): 
    args=parse_args() 
    samples=open(args.samples,'r').read().strip().split('\n') 
    sample_r1=[] 
    sample_r2=[] 
    control_r1=[] 
    control_r2=[] 
    for sample in samples: 
        json_name='/'.join([args.base_dir,sample,sample+'.json'])
        data=json.load(open(json_name,'r'))
        #get the r1, r2 fastqs for sample and control 
        r1_cur_sample=data['chip.fastqs_rep1_R1'][0] 
        r2_cur_sample=data['chip.fastqs_rep1_R2'][0] 
        r1_cur_control=data['chip.ctl_fastqs_rep1_R1'][0] 
        r2_cur_control=data['chip.ctl_fastqs_rep1_R2'][0] 
        sample_r1.append(r1_cur_sample) 
        sample_r2.append(r2_cur_sample) 
        control_r1.append(r1_cur_control) 
        control_r2.append(r2_cur_control) 
    #write the output script
    outf=open(args.outf,'w') 
    outf.write("#!/bin/bash\n") 
    outf.write('basename='+args.base_dir+'\n')
    outf.write('R1_samples=('+' '.join(sample_r1)+')\n')
    outf.write('R2_samples=('+' '.join(sample_r2)+')\n')
    outf.write('R1_controls=('+' '.join(control_r1)+')\n')
    outf.write('R2_controls=('+' '.join(control_r2)+')\n')
    outf.write('samples=('+' '.join(samples)+')\n')
    outf.write('len=${#samples[@]}\n')
    outf.write('for (( i=0; i<$len; i++ ))\n')
    outf.write('do\n') 
    outf.write('sample="${samples[$i]}"\n') 
    outf.write('R1_sample="${R1_samples[$i]}"\n') 
    outf.write('R2_sample="${R2_samples[$i]}"\n') 
    outf.write('R1_control="${R1_controls[$i]}"\n') 
    outf.write('R2_control="${R2_controls[$i]}"\n')     
    outf.write('sbatch -p akundaje --nodes=1 --ntasks=1 --cpus-per-task=10 --time=06:00:00 --job-name=$sample -o logs/$sample.o -e logs/$sample.e trim_adapters.sh $R1_sample $R2_sample $basename/$sample/$sample $R1_control $R2_control $basename/$sample/control_$sample\n')
    outf.write('done\n') 

if __name__=="__main__": 
    main() 
