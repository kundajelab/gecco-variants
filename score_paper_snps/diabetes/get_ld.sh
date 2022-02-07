#!/bin/bash
#for the novel snps 
module load plink/1.9
#diabetes snp list 
plink --allow-extra-chr --bfile ../../LD_EAS_CEU/EUR_phase3 --ld-snp-list snps.for.ld.txt  --out snps.for.ld.EUR.ld.r2  --r2 --ld-window-r2 0.2 --ld-window 500000 
plink --allow-extra-chr --bfile ../../LD_EAS_CEU/EAS_phase3 --ld-snp-list snps.for.ld.txt  --out snps.for.ld.EAS.ld.r2  --r2 --ld-window-r2 0.2 --ld-window 500000 
