library(ggplot2)
data=read.table("mpra_results.txt",header=TRUE,sep='\t')
data$Window=factor(data$Window,levels=c("left","center","right"))
p1=ggplot(data,aes(x=Window,y=RNACount,group=Allele,fill=Allele))+
  geom_bar(stat='identity',position='dodge')+
  scale_fill_manual(values=c("#e41a1c","#377eb8"))+
  xlab("Window")+
  ylab("RNA Count")+
  theme_bw(20)


p2=ggplot(data,aes(x=Window,y=PlasmidCount,group=Allele,fill=Allele))+
  geom_bar(stat='identity',position='dodge')+
  scale_fill_manual(values=c("#e41a1c","#377eb8"))+
  xlab("Window")+
  ylab("PlasmidCount")+
  theme_bw(20)


p3=ggplot(data,aes(x=Window,y=log2FC,group=Allele,fill=Allele))+
  geom_bar(stat='identity',position='dodge')+
  scale_fill_manual(values=c("#e41a1c","#377eb8"))+
  xlab("Window")+
  ylab("log2(Fold Change)")+
  theme_bw(20)

p4=ggplot(data,aes(x=Window,y=X.log10Pval,group=Allele,fill=Allele))+
  geom_bar(stat='identity',position='dodge')+
  scale_fill_manual(values=c("#e41a1c","#377eb8"))+
  xlab("Window")+
  ylab("-log10(Adj-pval)")+
  theme_bw(20)
source("~/helpers.R")
multiplot(p1,p2,p3,p4,cols=2)