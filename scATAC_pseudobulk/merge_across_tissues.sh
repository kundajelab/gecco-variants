#!/bin/bash 

#merges tagAlign files for same cell type across different colon sub-tissues 
cut -f11 -d'/' tagAligns.HTAN.txt | cut -f3- -d '-'| sort |uniq | cut -f1 -d'.'  > HTAN.celltypes.unique.txt 
for celltype in `cat HTAN.celltypes.unique.txt` 
do
    echo $celltype 
    zcat /oak/stanford/groups/akundaje/projects/GECCO/scATAC/HTAN/pseudobulk_tagAligns/*$celltype.tagAlign.gz >> /oak/stanford/groups/akundaje/projects/GECCO/scATAC/HTAN/pseudobulk_tagAligns_tissue_merged/$celltype.tagAlign
    gzip /oak/stanford/groups/akundaje/projects/GECCO/scATAC/HTAN/pseudobulk_tagAligns_tissue_merged/$celltype.tagAlign
done 


