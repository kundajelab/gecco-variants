#!/bin/bash

#HTAN single cell 
#Rscript tissue_specific_snp_annotation.R htan_peaks.txt /srv/scratch/annashch/gecco/ldsc/peaks/htan/lifted /srv/scratch/annashch/gecco/ldsc/tissue_specific_snp_annotation/htan

#ENCODE single cell
#Rscript tissue_specific_snp_annotation.R scENCODE_peaks.txt /srv/scratch/annashch/gecco/ldsc/peaks/scENCODE_peaks/lifted/ /srv/scratch/annashch/gecco/ldsc/tissue_specific_snp_annotation/scENCODE

#GECCO model peaks
Rscript tissue_specific_snp_annotation.R model_peaks.txt /srv/scratch/annashch/gecco/ldsc/peaks/model_peaks/ /srv/scratch/annashch/gecco/ldsc/tissue_specific_snp_annotation/model_peaks &

#Roadmap Peaks
Rscript tissue_specific_snp_annotation.R roadmap_peaks.txt /srv/scratch/annashch/gecco/ldsc/peaks/roadmap_peaks/ /srv/scratch/annashch/gecco/ldsc/tissue_specific_snp_annotation/roadmap_peaks &

#Roadmap Enhancers 
Rscript tissue_specific_snp_annotation.R roadmap_enhancer_annotations.txt /srv/scratch/annashch/gecco/ldsc/peaks/roadmap_enhancer_annotations/ /srv/scratch/annashch/gecco/ldsc/tissue_specific_snp_annotation/roadmap_enhancer_annotations &
