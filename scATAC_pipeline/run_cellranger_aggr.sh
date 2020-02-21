#!/bin/bash
module load cellranger-atac
cellranger-atac aggr --id=colon_gecco \
                  --csv=/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/cellranger_aggr/inputs.csv \
                  --normalize=depth \
		  --reference /mnt/data/annotations/cellranger-atac/refdata-cellranger-atac-GRCh38-1.2.0

