rm(list=ls())
library(ggplot2)
d1=read.table("loci.to.num.peak.snps.txt",header=FALSE,sep='\t')
d2=read.table("loci.to.num.dnase.peak.snps.txt",header=FALSE,sep='\t')
d3=read.table("loci.to.num.h3k27ac.peak.snps.txt",header=FALSE,sep='\t')
source("~/helpers.R")
p1=ggplot(data=d1,
          aes(x=d1$V2))+
  geom_histogram(binwidth = 1)+
  xlab("N loci")+
  ylab("N SNPs in DNAs/H3K27ac Peaks")

p2=ggplot(data=d2,
          aes(x=d2$V2))+
  geom_histogram(binwidth = 1)+
  xlab("N loci")+
  ylab("N SNPs in DNAse Peaks")

p3=ggplot(data=d3,
          aes(x=d3$V2))+
  geom_histogram(binwidth = 1)+
  xlab("N loci")+
  ylab("N SNPs in H3K27ac Peaks")

multiplot(p1,p2,p3,cols=1)