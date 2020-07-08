#!/bin/bash
module load plink/1.9
plink --allow-extra-chr --bfile EUR_phase3 --ld-snp-list rsid.txt  --out EUR.ld.r2  --r2 --ld-window 50000
plink --allow-extra-chr --bfile EAS_phase3 --ld-snp-list rsid.txt  --out EAS.ld.r2  --r2 --ld-window 50000
