#!/bin/bash
module load cellranger-atac
cellranger-atac count  --id=scATAC_W76_MODC_B_10931_X016_S03_B1_T1 --fastqs=/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/raw/HKYLHDSXX/scATAC_W76_MODC_B_10931_X016_S03_B1_T1_S16,/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/raw/HMGLLDSXX/scATAC_W76_MODC_B_10931_X016_S03_B1_T1_S16 --reference=/mnt/data/annotations/cellranger-atac/refdata-cellranger-atac-GRCh38-1.2.0

