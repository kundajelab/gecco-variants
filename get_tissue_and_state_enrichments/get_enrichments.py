import pandas as pd 
import pdb 
all_p_vals=dict() 
low_p_vals=dict() 
thresh=5e-8
prefix="/oak/stanford/groups/akundaje/lab_data/kundaje/projects/GECCO/annotated_colorectal_cancer_gwas_summary_statistics"
for chrom in range(1,23): 
    data=pd.read_csv(prefix+'/'+'annotations.chr'+str(chrom)+'.bed',header=0,sep='\t')
    print("loaded data for chrom:"+str(chrom))
    for index,row in data.iterrows():
        if pd.isnull(row['ScreenTissue_State']): 
            continue 
        cur_p=float(row['P-value'])        
        screen_entries=[entry for entry in row['ScreenTissue_State'].split(',') if '_' in entry]
        for cur_entry in screen_entries: 
            if cur_entry not in all_p_vals: 
                all_p_vals[cur_entry]=1 
            else: 
                all_p_vals[cur_entry]+=1 
        if cur_p < thresh:
            print(str(cur_p))
            for cur_entry in screen_entries: 
                if cur_entry not in low_p_vals: 
                    low_p_vals[cur_entry]=1 
                else: 
                    low_p_vals[cur_entry]+=1 
outf=open("enrichment_tallies.all.tsv",'w')
outf.write('Tissue_State\tAllSNPs\tSignificantHits\n')
for entry in all_p_vals: 
    outf.write(entry+'\t'+str(all_p_vals[entry]))
    if entry in low_p_vals: 
        outf.write('\t'+str(low_p_vals[entry]))
    else: 
        outf.write('\t0')
    outf.write('\n')


        
