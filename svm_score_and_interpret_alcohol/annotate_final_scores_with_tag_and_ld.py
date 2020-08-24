import pdb
import pandas as pd 
#scores=pd.read_csv("gecco.snps.alcohol.svm.scores.txt",header=0,sep='\t')
scores=pd.read_csv("gecco.snps.alcohol.svm.scores.scaled.txt",header=0,sep='\t')
ld=pd.read_csv("alcohol.ldwindow.100kb.r2.gt.0.5.txt",header=0,sep='\t')
alleles=pd.read_csv("alcohol.snps.in.region.annotated.txt",header=0,sep='\t')
print("loaded data")
merged=scores.merge(ld,left_on=['SNP'],right_on=['SNP_B']).merge(alleles,left_on=['SNP'],right_on=['RSID'])
subset=merged[['SNP', 'colo205.REF', 'colo205.ALT', 'colo205.ALT.REF', 'hct116.REF','hct116.ALT', 'hct116.ALT.REF', 'sw480.REF', 'sw480.ALT','sw480.ALT.REF', 'dnase_c.REF', 'dnase_c.ALT', 'dnase_c.ALT.REF','dnase_v.REF', 'dnase_v.ALT', 'dnase_v.ALT.REF', 'CHR_A', 'BP_A','SNP_A', 'CHR_B', 'BP_B', 'R2', 'Ref','Alt']]
subset=subset.rename(columns={'CHR_A':'CHR_TAG',
                       'BP_A':'Pos1_TAG',
                       'SNP_A':'Tag',
                       'CHR_B':'Chr',
                       'BP_B':'Pos1'})
#subset.to_csv("gecco.snps.alcohol.svm.scores.annotated.txt",sep='\t',header=True,index=False)
subset.to_csv("gecco.snps.alcohol.svm.scores.scaled.annotated.txt",sep='\t',header=True,index=False)


