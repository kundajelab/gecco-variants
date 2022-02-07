#generate an all-snps list for variants for the  diabetes manusript
import pandas as pd
import pdb
for ancestry in ['EUR','EAS']:
    bim_file=pd.read_csv("/srv/scratch/annashch/gecco/LD_EAS_CEU/"+ancestry+'_phase3.bim',header=None,sep='\t')
    print(bim_file.head())
    snps_of_interest=pd.read_csv("snps.for.ld."+ancestry+".ld.r2.ld",header=0,delim_whitespace=True)
    outf=open('all.snps.diabetes.'+ancestry+'.txt','w')
    outf.write('\t'.join(['Chr','RSID','Gap','Pos1','Ref','Alt'])+'\n')
    snp_b=list(snps_of_interest["SNP_B"])
    print("querying "+str(len(snp_b))+" snps")
    bim_subset=bim_file[bim_file[1].isin(snp_b)]
    print("subset selected:"+str(bim_subset.shape))
    for index,row in bim_subset.iterrows():
        outf.write('\t'.join([str(i) for i in row])+'\n')
    outf.close()

