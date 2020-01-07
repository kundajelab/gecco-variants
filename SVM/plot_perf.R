rm(list=ls())
library(ggplot2)
data=read.table("aggregate_performance.tsv",header=TRUE,sep='\t')
data=data[data$Metric %in% c("auprc", 
                             "auroc", 
                             "balanced_accuracy", 
                             "negative_accuracy",
                             "positive_accuracy",
                             "recall_at_fdr_50",
                             "recall_at_fdr_20"),]
attach(data)
ggplot(data, aes(x = Fold,y=Val,group=Model,fill=Model)) +
  geom_bar(stat='identity',position='dodge') +
  facet_grid(rows=vars(Metric),cols=vars(Task))+
  scale_fill_manual(values=c("#e41a1c",'#377eb8'))+
  scale_x_continuous(name="Fold",breaks=seq(0,9),labels=seq(0,9))
