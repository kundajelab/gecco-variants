rm(list=ls())
library(ggplot2)
library(reshape2)
data=read.table("scacheri.annotated.reshaped.enrichments.txt",header=TRUE,sep=',')

p1=ggplot(data=data,
       aes(x=data$Pval,
           y=data$Enrichment,
           group=data$Experiment,
           color=data$Tissue,
           linetype=data$Assay))+
  geom_line(size=1)+
  xlab("-log p-value")+
  ylab("Fold Enrichment")+
  ggtitle("GECCO dataset GWAS enrichments")+
  theme_bw(20)+
  xlim(0,15)+
  ylim(1,4)+
  scale_linetype_manual(name="Assay",values=c('solid','dashed','dotted'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#ffff33','#a65628','#f781bf','#999999'),name="Experiment")
  
bulk=data[data$Assay!="scATAC",]
p2=ggplot(data=bulk,
          aes(x=bulk$Pval,
              y=bulk$Enrichment,
              group=bulk$Experiment,
              color=bulk$Tissue,
              linetype=bulk$Assay))+
  geom_line(size=1)+
  xlab("-log p-value")+
  ylab("Fold Enrichment")+
  ggtitle("GECCO dataset GWAS enrichments")+
  theme_bw(20)+
  xlim(0,15)+
  ylim(1,4)+
  scale_linetype_manual(name="Assay",values=c('solid','dashed','dotted'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#ffff33','#a65628','#f781bf','#999999'),name="Experiment")
