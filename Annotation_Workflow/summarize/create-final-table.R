#!/usr/bin/env Rscript

library(dplyr)
library(stringr)

results_dir = "/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_output/"

chromatin = read.table(paste0(results_dir, "summary_dhs_chromatin_marks.tsv"), header=T, sep="\t", as.is=T)
tfbs = read.table(paste0(results_dir, "summary_predicted_TFBS_motif_overlap.tsv"), header=T, sep="\t", as.is=T)
tf_chipseq = read.table(paste0(results_dir, "summary_ENCODE_TxnFac_overlap.tsv"), header=T, sep="\t", as.is=T)
vel = read.table(paste0(results_dir, "summary_VEL.tsv"), header=T, sep="\t", as.is=T)
vep = read.table(paste0(results_dir, "vep_summary.txt"), header=T, sep="\t", as.is=T)
gtex = read.table(paste0(results_dir, "eQTL_summary.tsv"), header=T, sep="\t", as.is=T)

names(vep)[1] = "variant"
names(gtex) = c("variant", "genes_transverse_colon", "genes_n_tissues", "genes_all_tissues")

chromatin$Chr = (str_split_fixed(chromatin$variant, "-", 4))[,1]
chromatin$Pos = (str_split_fixed(chromatin$variant, "-", 4))[,2]

names(tfbs) = c("rsID", "Predicted_TFBS_motifs")

merged_table = full_join(vep, chromatin, by="variant") 

merged_table = full_join(merged_table, tfbs, by="rsID")

names(tf_chipseq) = c("variant","ENCODE_TF_ChIP-seq")

merged_table = full_join(merged_table, tf_chipseq, by="variant")

merged_table = full_join(merged_table, vel, by=c("variant"="SNP"))

merged_table = full_join(merged_table, gtex, by="variant")

merged_table = select(merged_table, variant, rsID, Chr, Pos, Consequence, SYMBOL, normal_crypt_H3K27ac, crc_H3K27ac, VEL, normal_crypt_DHS, normal_mucosa_ATACseq, crc_dhs, Adrenal_or_pancreas, CNS, Cardiovascular, Connective_or_bone, Gastrointestinal, Immune_or_hematopoietic, Kidney, Liver, Skeletal_muscle, Other, Predicted_TFBS_motifs, 'ENCODE_TF_ChIP-seq', CADD_PHRED, DANN_score, PolyPhen, FATHMM_pred, FATHMM_score, genes_transverse_colon, genes_n_tissues, genes_all_tissues)

merged_table$Chr = as.numeric(merged_table$Chr)
merged_table$Pos = as.numeric(merged_table$Pos)

merged_table = merged_table[order(merged_table$Chr, merged_table$Pos),]

write.table(merged_table, "Supplementary_Table_Functional_Annotations.tsv", row.names=F, sep="\t", quote=F)
