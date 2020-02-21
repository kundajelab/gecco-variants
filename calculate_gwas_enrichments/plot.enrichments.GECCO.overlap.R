rm(list=ls())
library(ggplot2)
library(reshape2)

cols=c(     "#FF0000",
            "#FFFF00",
            "#00EAFF",
            "#AA00FF",
            "#FF7F00",
            "#BFFF00",
            "#0095FF",
            "#FF00AA",
            "#FFD400",
            "#6AFF00",
            "#0040FF",
            "#EDB9B9",
            "#B9D7E9",
            "#E7E9B9",
            "#DCB9ED",
            "#B9EDE0",
            "#8F2323",
            "#23628F",
            "#8F6A23",
            "#6B238F",
            "#4F8F23",
            "#000000",
            "#737373",
            "#CCCCCC",
           '#FF00AA',
           '#4F8F23')

data=read.table("annotated.reshaped.enrichments.txt",header=TRUE,sep='\t')
p1=ggplot(data=data,
       aes(x=data$pval,
           y=data$enrichment,
           group=data$tissue,
           color=data$celltype))+
  geom_line(size=0.3)+
  scale_color_manual(name="Group",values=cols)+
  xlab("-log p-value")+
  ylab("Fold Enrichment")+
  ggtitle("GECCO CRC GWAS+Roadmap DNAse + ChromHMM Enhancers")+
  theme_bw(20)+
  xlim(0,15)+
  ylim(1,4)

scacheri=data[data$group=="Scacheri",]
p2=ggplot(data=scacheri,
          aes(x=scacheri$pval,
              y=scacheri$enrichment,
              group=scacheri$tissue,
              color=scacheri$celltype))+
  geom_line(size=0.3)+
  scale_color_manual(name="Group",values=cols)+
  xlab("-log p-value")+
  ylab("Fold Enrichment")+
  ggtitle("GECCO CRC GWAS")+
  theme_bw(20)+
  xlim(0,15)+
  ylim(1,4)

enh=data[data$group=="Enh",]
p3=ggplot(data=enh,
          aes(x=enh$pval,
              y=enh$enrichment,
              group=enh$tissue,
              color=enh$celltype))+
  geom_line(size=0.3)+
  scale_color_manual(name="Group",values=cols)+
  xlab("-log p-value")+
  ylab("Fold Enrichment")+
  ggtitle("ChromHMM Enhancers")+
  theme_bw(20)+
  xlim(0,15)+
  ylim(1,4)

dnase=data[data$group=="200k",]
p4=ggplot(data=dnase,
          aes(x=dnase$pval,
              y=dnase$enrichment,
              group=dnase$tissue,
              color=dnase$celltype))+
  geom_line(size=0.3)+
  scale_color_manual(name="Group",values=cols)+
  xlab("-log p-value")+
   ylab("Fold Enrichment")+
  ggtitle("Roadmap DNAse top 200k peaks")+
  theme_bw(20)+
  xlim(0,15)+
  ylim(1,4)

