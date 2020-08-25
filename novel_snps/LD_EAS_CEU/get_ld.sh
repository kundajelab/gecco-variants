#!/bin/bash
#for the novel snps 
module load plink/1.9
#plink --allow-extra-chr --bfile EUR_phase3 --ld-snp-list rsid.txt  --out EUR.ld.r2  --r2 --ld-window 50000
#plink --allow-extra-chr --bfile EAS_phase3 --ld-snp-list rsid.txt  --out EAS.ld.r2  --r2 --ld-window 50000

#for alcohol snps
plink --allow-extra-chr --bfile EUR_phase3 --ld-snp-list alcohol.rsid.txt  --out alcohol.EUR.ld.r2  --r2 --ld-window 100000
plink --allow-extra-chr --bfile EAS_phase3 --ld-snp-list alcohol.rsid.txt  --out alcohol.EAS.ld.r2  --r2 --ld-window 100000
