#!/bin/bash

#by cluster
#for i in 16 #`seq 1 22`
#do
#python tagAlign_from_fragments.py --frags /oak/stanford/groups/akundaje/projects/GECCO/scATAC/clusters/idx$i.bed --outf idx$i.tagAlign
#done

#all samples
#python tagAlign_from_fragments.py --frags /oak/stanford/groups/akundaje/projects/ENCODE_scATAC/cellranger_aggr/colon_gecco_cellranger_v.1.2.0/outs/fragments.tsv.gz --outf all.tagAlign

#by tissue
for i in COLL COLM MODC
do
    python tagAlign_from_fragments.py --frags $i.fragments.bed --outf $i.tagAlign &
done
    
