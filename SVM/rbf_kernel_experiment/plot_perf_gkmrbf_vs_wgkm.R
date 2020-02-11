rm(list=ls())
library(ggplot2)
data=read.table("aggregate_performance_wgkm_vs_gkmrbf.tsv",header=TRUE,sep='\t')
ggplot(data=data,
       aes(x=data$auPRC_GKMRBF,y=data$auPRC_WGKM,group=data$Task,color=data$Task,label=data$Fold))+
  geom_point(alpha=0.5,size=5)+
  geom_text()+
  xlim(0.8,1)+
  ylim(0.8,1)+
  geom_abline(x=seq(0,1,0.2),y=seq(0,1,0.02))+
  scale_color_manual(name="Task",values = c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'))+
  xlab("auPRC GKMRBF")+
  ylab("auPRC WGKM")
  

