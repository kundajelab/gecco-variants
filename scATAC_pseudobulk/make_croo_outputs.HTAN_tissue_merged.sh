#!/bin/bash
prefix=/oak/stanford/groups/akundaje/projects/GECCO/scATAC/HTAN
hashes=(cfd66d2c-4b1e-4cf9-be43-c4fe60926a07 19ef0f89-6231-4458-87a8-6c56e60d501a 53c19b20-1009-4e63-9d9f-238915a51c6f 0411b8df-8113-41b2-b194-59ab58ba82b3 b5916f74-a912-47fb-9776-b9c24cee6286 a4a2fd7f-db9c-495d-bb75-51787430f53f e1afbc33-2538-446d-a9f5-1e46a3c56d48 a3bc1797-8eaa-4c0f-b3b8-7073910ebc65 ac9d7553-a12a-46c4-b82b-6c23bccc64eb f8b61055-b5ef-4942-9856-a99f8ec1d740 a4fe8e95-28d5-42a3-879f-fadbd476896e c84b79cf-7d16-499c-a11f-772943a3ade8 d2cae182-365c-465c-9680-e68db83cdf2b 700a24d7-17ef-4c8b-9403-fba7ab3b0f12 a1129710-36bf-42be-900a-1369ea8d64ac 83c23355-2053-45ef-86db-f68d2a5618c8 1e8f291d-bc88-431d-8689-4473e8c532b5 ab07770a-94c0-4712-bf62-ce36bbb4929e)
samples=(Crypt-Fibroblasts Goblet Enterocytes Myofibroblasts Mast-cells Stromal Endothelial Best4pos-Enterocytes Immature-Goblet1 Intestinal-Stem-Cells-LGR5pos B-cells Monocytes T-cells Villus-Fibroblasts Intestinal-Stem-Cells Myofibroblasts2 StromalOther Immature-Goblet2)
## get length of $distro array
len=${#samples[@]}
 
## Use bash for loop 
for (( i=0; i<$len; i++ ))
do
    cur_hash=${hashes[$i]}
    cur_sample=${samples[$i]}
    echo $cur_hash
    echo $cur_sample
    croo $prefix/pseudobulk_pipeline_outputs_tissue_merged/atac/$cur_hash/metadata.json  --method copy --out-dir $prefix/croo_tissue_merged/$cur_sample 
done
