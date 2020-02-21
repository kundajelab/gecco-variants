rm(list=ls())
library(ggplot2)
source("~/helpers.R")
colors=c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c','#fdbf6f','#ff7f00','#cab2d6','#6a3d9a','#ffff99','#b15928','#8dd3c7','#ffffb3','#bebada','#fb8072','#80b1d3')
n_tss=62188
h3k27ac_tss=read.table("tss_to_prox_enh_counts.reg2map.p2.txt",header=FALSE,sep='\t')
p1=ggplot(data=h3k27ac_tss,aes(x=h3k27ac_tss$V1,y=h3k27ac_tss$V2,fill=h3k27ac_tss$V1))+
  geom_bar(stat="identity")+
  scale_fill_manual(values=colors,name="Dataset")+
  ggtitle("TSS for expressed transcripts \n that are within 5kb of enhancer\n in HoneyBadger2 p2")+
  xlab("Dataset")+
  ylab("TSS's")+
  theme_bw(20)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
h3k27ac_genes=read.table("gene_to_prox_enh_counts.reg2map.p2.txt",header=FALSE,sep='\t')
p2=ggplot(data=h3k27ac_genes,aes(x=h3k27ac_genes$V1,y=h3k27ac_genes$V2,fill=h3k27ac_tss$V1))+
  geom_bar(stat="identity")+
  scale_fill_manual(values=colors,name="Dataset")+
  ggtitle("Expressed genes with 1+ TSS's that are within 5kb of enhancer\n in HoneyBadger2 p2")+
  xlab("Dataset")+
  ylab("Genes")+
  theme_bw(20)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
multiplot(p1,p2,cols=2)

h3k27ac_enh=read.table("prox_enh_counts.reg2map.p2.txt",header=FALSE,sep='\t')
h3k27ac_enh$V3=h3k27ac_enh$V2/h3k27ac_enh$V3
p3=ggplot(data=h3k27ac_enh,aes(x=h3k27ac_enh$V1,y=h3k27ac_enh$V2,fill=h3k27ac_enh$V1))+
  geom_bar(stat="identity")+
  scale_fill_manual(values=colors,name="Dataset")+
  ggtitle("Number of Overlap Peaks that are within 5kb of TSS \n (HoneyBadger2 p2)")+
  xlab("Dataset")+
  ylab("Peaks within 5kb of TSS")+
  theme_bw(15)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
p4=ggplot(data=h3k27ac_enh,aes(x=h3k27ac_enh$V1,y=h3k27ac_enh$V3,fill=h3k27ac_enh$V1))+
  geom_bar(stat="identity")+
  scale_fill_manual(values=colors,name="Dataset")+
  ggtitle("Fraction of Overlap Peaks that are within 5kb of TSS \n (HoneyBadger2 p2)")+
  xlab("Dataset")+
  ylab("Fraction of Peaks that are within 5kb of TSS")+
  theme_bw(15)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
multiplot(p3,p4,cols=2)