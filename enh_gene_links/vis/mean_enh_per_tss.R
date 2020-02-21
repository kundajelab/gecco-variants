rm(list=ls())
library(ggplot2)
data=read.table("enh_per_gene_by_source.txt",header=TRUE,sep='\t')
ggplot(data=data,aes(x=data$count,group=data$source,color=data$source))+
  geom_density()+
  xlab("Number of enhancers associated with a TSS")+
  xlim(0,15)