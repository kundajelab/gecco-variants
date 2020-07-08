import os
import shutil 
snp_to_tag=open('snp_to_tag.txt','r').read().strip().split('\n')
snp_to_tag_map={}
for line in snp_to_tag:
    tokens=line.split('\t')
    snp_to_tag_map[tokens[0]]=tokens[1]
plots=open('plots.txt','r').read().strip().split('\n')
for plot in plots:
    snp=plot.split('/')[-1].split('_')[2]
    tag=snp_to_tag_map[snp]
    if os.path.isdir('plots_grouped_by_tag/'+tag)==False:
        os.mkdir('plots_grouped_by_tag/'+tag)
    shutil.copy2(plot,'plots_grouped_by_tag/'+tag+'/')
    
