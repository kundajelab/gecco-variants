#generate an all-snps list for variants for the  diabetes manusript
import pandas as pd
dbsnp=pd.read_csv("chr2.snp142.txt",header=None,sep='\t')
snps_of_interest=pd.read_csv("EUR_chr2_135594399_ld.ld",header=0,sep='\t')
snp_pos1=list(snps_of_interest["BP_B"])
print("querying "+str(len(snp_pos1))+" snps")
dbsnp_subset=dbsnp[dbsnp[3].isin(snp_pos1)]
print("subset selected:"+str(dbsnp_subset.shape))
dbsnp_subset_cols_of_interest=dbsnp_subset[[1,2,3,4,9,24]]
dbsnp_subset_cols_of_interest.to_csv("EUR_ld_cols_of_interest.txt",sep='\t',header=False,index=False)
outf=open('all.snps.calcium.txt','w')
outf.write('\t'.join(['Chr','RSID','Pos1','Ref','Alt'])+'\n')
#list of ld snps for the diabetes paper
for index,row in dbsnp_subset_cols_of_interest.iterrows():
    chrom=row[1]
    pos1=row[3]
    rsid=row[4]
    alleles=row[9].split('/')
    if len(alleles)==1:
        continue 
    if type(row[24])==float:
        row[24]=str(row[24])
    maf=[float(i) for i in row[24].strip(',').split(',')]    
    sorted_alleles=sorted(zip(maf,alleles))
    try:
        major_allele=sorted_alleles[-1][1]
        minor_allele=sorted_alleles[-2][1]
        outf.write('\t'.join([str(i) for i in [chrom,rsid,pos1,major_allele,minor_allele]])+'\n')
    except:
        print('skipping:'+str(row))
outf.close()

