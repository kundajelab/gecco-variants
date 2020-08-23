from os import listdir
from os.path import isfile, join
ref_runs1="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores_flora/pred_ref"
alt_runs1="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores_flora/pred_alt"
ref_runs2="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores_flora/pred_ref2"
alt_runs2="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores_flora/pred_alt2"
combined_ref="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores_flora/pred_ref_aggregate"
combined_alt="/oak/stanford/groups/akundaje/projects/GECCO/genome_wide_scores_flora/pred_alt_aggregate"

batch1_refs=[f for f in listdir(ref_runs1) if isfile(join(ref_runs1,f))]
batch1_alts=[f for f in listdir(alt_runs1) if isfile(join(alt_runs1,f))]
for ref_file in batch1_refs: 
    print(str(ref_file))
    ref1=open('/'.join([ref_runs1,ref_file]),'r').read().strip().split('\n')[0:-1] #dump the last line 
    ref2=open('/'.join([ref_runs2,ref_file]),'r').read().strip().split('\n')
    #merge the two files 
    out_merged_ref=open('/'.join([combined_ref,ref_file]),'w')
    out_merged_ref.write('\n'.join(ref1)+'\n'+'\n'.join(ref2)+'\n')
    out_merged_ref.close() 

for alt_file in batch1_alts: 
    print(str(alt_file))
    alt1=open('/'.join([alt_runs1,alt_file]),'r').read().strip().split('\n')[0:-1] #dump the last line 
    alt2=open('/'.join([alt_runs2,alt_file]),'r').read().strip().split('\n')
    #merge the two files 
    out_merged_alt=open('/'.join([combined_alt,alt_file]),'w')
    out_merged_alt.write('\n'.join(alt1)+'\n'+'\n'.join(alt2)+'\n')
    out_merged_alt.close() 

    
