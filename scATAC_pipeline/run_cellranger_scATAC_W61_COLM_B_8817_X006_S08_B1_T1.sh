#!/bin/bash
module load cellranger-atac
cellranger-atac count  --id=scATAC_W61_COLM_B_8817_X006_S08_B1_T1 --fastqs=/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/raw/HKYCWDSXX/scATAC_W61_COLM_B_8817_X006_S08_B1_T1_S2,/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/raw/HMGLLDSXX/scATAC_W61_COLM_B_8817_X006_S08_B1_T1_S6 --reference=/mnt/data/annotations/cellranger-atac/refdata-cellranger-atac-GRCh38-1.2.0

