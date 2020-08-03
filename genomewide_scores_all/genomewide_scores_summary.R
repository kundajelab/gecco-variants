rm(list=ls())
library(ggplot2)
data=read.table("gecco.snps.in.peaks.svm.scores.txt",header=TRUE,sep='\t',row.names=1)
means=colMeans(data)
std=apply(as.matrix(data),2,sd)
summary=rbind(means,std)
write.table(summary,file="mean_and_std.tsv",quote=FALSE,sep='\t',row.names=TRUE,col.names=TRUE)
cols=c("REF"="#0000FF","ALT"="#FF0000")
data=as.data.frame(scale(data))
write.table(round(data,3),file="gecco.snps.in.peaks.svm.scores.scaled.txt",quote=FALSE,row.names=TRUE,col.names=TRUE,sep='\t')
p1=ggplot(data=data)+
  geom_histogram(aes(x=colo205.REF,fill='REF'),alpha=0.4,bins=100)+
  geom_histogram(aes(x=colo205.ALT,fill='ALT'),alpha=0.4,bins=100)+
  xlab("GKM SVM score")+
  ggtitle("COLO205")+
  scale_fill_manual(values=cols)

p2=ggplot(data=data)+
  geom_histogram(aes(x=colo205.ALT.REF),bins=100)+
  xlab("GKM SVM score ALT - REF ")+
  ggtitle("COLO205")


p3=ggplot(data=data)+
  geom_histogram(aes(x=hct116.REF,fill='REF'),alpha=0.4,bins=100)+
  geom_histogram(aes(x=hct116.ALT,fill='ALT'),alpha=0.4,bins=100)+
  xlab("GKM SVM score")+
  ggtitle("HCT116")+
  scale_fill_manual(values=cols)

p4=ggplot(data=data)+
  geom_histogram(aes(x=hct116.ALT.REF),bins=100)+
  xlab("GKM SVM score ALT - REF ")+
  ggtitle("HCT116")


p5=ggplot(data=data)+
  geom_histogram(aes(x=sw480.REF,fill='REF'),alpha=0.4,bins=100)+
  geom_histogram(aes(x=sw480.ALT,fill='ALT'),alpha=0.4,bins=100)+
  xlab("GKM SVM score")+
  ggtitle("SW480")+
  scale_fill_manual(values=cols)

p6=ggplot(data=data)+
  geom_histogram(aes(x=sw480.ALT.REF),bins=100)+
  xlab("GKM SVM score ALT - REF ")+
  ggtitle("SW480")


p7=ggplot(data=data)+
  geom_histogram(aes(x=dnase_c.REF,fill='REF'),alpha=0.4,bins=100)+
  geom_histogram(aes(x=dnase_c.ALT,fill='ALT'),alpha=0.4,bins=100)+
  xlab("GKM SVM score")+
  ggtitle("Controls")+
  scale_fill_manual(values=cols)

p8=ggplot(data=data)+
  geom_histogram(aes(x=dnase_c.ALT.REF),bins=100)+
  xlab("GKM SVM score ALT - REF ")+
  ggtitle("Controls")

p9=ggplot(data=data)+
  geom_histogram(aes(x=dnase_v.REF,fill='REF'),alpha=0.4,bins=100)+
  geom_histogram(aes(x=dnase_v.ALT,fill='ALT'),alpha=0.4,bins=100)+
  xlab("GKM SVM score")+
  ggtitle("Tumor")+
  scale_fill_manual(values=cols)

p10=ggplot(data=data)+
  geom_histogram(aes(x=dnase_v.ALT.REF),bins=100)+
  xlab("GKM SVM score ALT - REF ")+
  ggtitle("Tumor")

source("~/helpers.R")
multiplot(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,cols=5)

#get stats 
nrow(data[data$colo205.ALT.REF > 2,])
nrow(data[data$colo205.ALT.REF < -2,])

nrow(data[data$hct116.ALT.REF > 2,])
nrow(data[data$hct116.ALT.REF < -2,])

nrow(data[data$sw480.ALT.REF > 2,])
nrow(data[data$sw480.ALT.REF < -2,])

nrow(data[data$dnase_c.ALT.REF > 2,])
nrow(data[data$dnase_c.ALT.REF < -2,])

nrow(data[data$dnase_v.ALT.REF > 2,])
nrow(data[data$dnase_v.ALT.REF < -2,])






