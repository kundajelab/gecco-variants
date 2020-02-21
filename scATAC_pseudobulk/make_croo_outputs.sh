#!/bin/bash
prefix=/oak/stanford/groups/akundaje/projects/GECCO/scATAC/pseudobulk_pipeline_outputs
hashes=(4c0446de-facd-475b-80fe-06ebf8a45a57 fb01041b-4ee2-4177-8e9e-34be3d725bb0 eab136cb-c1dd-4fef-9d39-f420904b1b67 4aa209d1-423e-4c36-babf-dcad35574839 70567a50-8923-420b-8623-aedd5a84de14 f2289740-de28-4ec3-bb7b-1a6a90740ffd b2cc8b70-72b4-449e-88b6-4d36c0b069a2 c682df27-499e-4c6c-a864-267af3936b5f 858b8e83-0f2b-40b8-9af5-46f9ffb41e46 d6e92b38-2cce-41b1-88eb-9eb63a1265cd 270405c6-3a94-4833-abca-21cefd9b0b8e 07a273b4-d784-49ae-8955-fc0452c2d066 0dfeec81-830f-453f-a34e-d8f14d4efe16 4ffa50bc-b25c-4555-8ae2-c538c84cafc4 192c5d1f-5664-4a3e-a25c-835fbb55c00a b0f1e10b-199a-44c3-9b2a-0d2d199f4b8c ad2d7ed6-819e-4646-87ba-59e54ddaf860 29119942-59af-4247-b33a-ecc3fb892601 8d054256-d679-4be5-83e9-8e23e4b43360 2e6b51d4-a9c8-410a-89c0-b215d917c12f 5acab0d3-0997-443e-b730-b178e4968ba9)
samples=(16 22 21 20 19 18 17 15 14 13 12 11 10 9 8 7 6 5 4 3 2)
for i in 12 #`seq 0 20`
do
    cur_hash=${hashes[$i]}
    cur_sample=${samples[$i]}
    echo $cur_hash
    echo $cur_sample
    croo $prefix/atac/$cur_hash/metadata.json  --out-def-json atac.croo.json --out-dir $prefix/croo/$cur_sample 
done
