rm(list=ls())
library(ggplot2)
data=read.table("toplot.csv",header=TRUE,sep='\t')
background=read.table("annotations.chr1.bed",header=TRUE,sep='\t')
background$Category="Background"
data=rbind(data,background)

p1=ggplot(data=data,aes(x=data$Freq1,fill=data$Category,color=data$Category))+
  geom_density(alpha=0.5)+
  xlab("Allele1 Frequency")+
  ylab("Density")+
  scale_fill_manual(values=c('#1b9e77','#d95f02','#7570b3'))+
  scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))
print(p1)

p2=ggplot(data=data,aes(x=data$GC.,fill=data$Category,color=data$Category))+
  geom_density(alpha=0.5)+
  xlab("GC%")+
  ylab("Density")+
  scale_fill_manual(values=c('#1b9e77','#d95f02','#7570b3'))+
  scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))
print(p2)


p3=ggplot(data=data,aes(x=data$DistDNASE,fill=data$Category,color=data$Category))+
  geom_density(alpha=0.1)+
  xlab("Distance to nearest HCT116 DNase peak")+
  ylab("Density")+
  scale_fill_manual(values=c('#1b9e77','#d95f02','#7570b3'))+
  scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))+
  xlim(0,100000)
print(p3)


p4=ggplot(data=data,aes(x=data$DistTSS,fill=data$Category,color=data$Category))+
  geom_density(alpha=0.1)+
  xlab("Distance to nearest TSS")+
  ylab("Density")+
  scale_fill_manual(values=c('#1b9e77','#d95f02','#7570b3'))+
  scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))+
  xlim(0,500000)
print(p4)


summary=read.table("summary_of_tissues_by_state.tsv",header=TRUE,sep='\t')
summary$Group=factor(summary$Group)
background=summary[summary$Category=="Background",]
positives=summary[summary$Category=="Positives",]
negatives=summary[summary$Category=="Negatives",]
p5=ggplot(data=positives,aes(x=positives$Group,y=positives$Count,color=positives$State,fill=positives$State))+
  geom_bar(stat="identity",position="stack")+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  xlab("Group")+
  ylab("Count")+
  ggtitle("Positives")
  
p6=ggplot(data=negatives,aes(x=negatives$Group,y=negatives$Count,color=negatives$State,fill=negatives$State))+
  geom_bar(stat="identity",position="stack")+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  xlab("Group")+
  ylab("Count")+
  ggtitle("Negatives")

p7=ggplot(data=background,aes(x=background$Group,y=background$Count,color=background$State,fill=background$State))+
  geom_bar(stat="identity",position="stack")+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  xlab("Group")+
  ylab("Count")+
  ggtitle("Background")

source('helpers.R')
multiplot(p5,p6,p7,cols=3)

summary=read.table("summary_of_tissues_by_state.detailed.tsv",header=TRUE,sep='\t')
background=summary[summary$Category=="Background",]
background=background[order(-background$Count),]
#levels(background$Tissue)=background$Tissue

positives=summary[summary$Category=="Positives",]
positives=positives[order(-positives$Count),]
#levels(positives$Tissue)=positives$Tissue

negatives=summary[summary$Category=="Negatives",]
negatives=negatives[order(-negatives$Count),]
#levels(negatives$Tissue)=negatives$Tissue


p8=ggplot(data=positives,aes(x=fct_reorder(positives$Tissue,positives$Count,.desc =TRUE),y=positives$Count,color=positives$State,fill=positives$State))+
  geom_bar(stat="identity",position="stack")+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  xlab("Group")+
  ylab("Count")+
  ggtitle("Positives")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

p9=ggplot(data=negatives,aes(x=fct_reorder(negatives$Tissue,negatives$Count,.desc =TRUE),y=negatives$Count,color=negatives$State,fill=negatives$State))+
  geom_bar(stat="identity",position="stack")+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  xlab("Group")+
  ylab("Count")+
  ggtitle("Negatives")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

p10=ggplot(data=background,aes(x=fct_reorder(background$Tissue,background$Count,.desc =TRUE),y=background$Count,color=background$State,fill=background$State))+
  geom_bar(stat="identity",position="stack")+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3'))+
  xlab("Group")+
  ylab("Count")+
  ggtitle("Background")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

