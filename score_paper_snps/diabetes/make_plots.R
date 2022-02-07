library(ggplot2)
library(reshape2)
#EUR or EAS 
#data=read.table("SVM predictions for diabetes loci - EUR.tsv",header=T,sep='\t')
data=read.table("SVM predictions for diabetes loci - EAS.tsv",header=T,sep='\t')
tag1=data[data$Chr==13,]
tag2=data[data$Chr==8,]

subset_tag1=subset(tag1,select=c('RSID','colo205.ref',
                                 'colo205.alt',
                                 'hct116.ref',
                                 'hct116.alt',
                                 'sw480.ref',
                                 'sw480.alt',
                                 'dnase_c.ref',
                                 'dnase_c.alt',
                                 'dnase_v.ref',
                                 'dnase_v.alt'))
m_tag1=melt(subset_tag1)

subset_tag2=subset(tag2,select=c('RSID','colo205.ref',
                                 'colo205.alt',
                                 'hct116.ref',
                                 'hct116.alt',
                                 'sw480.ref',
                                 'sw480.alt',
                                 'dnase_c.ref',
                                 'dnase_c.alt',
                                 'dnase_v.ref',
                                 'dnase_v.alt'))
m_tag2=melt(subset_tag2)

library(dplyr)
library(tidyr)
m_tag1=separate(data = m_tag1, col = variable, into = c("model", "allele"), sep = "\\.")
m_tag2=separate(data = m_tag2, col = variable, into = c("model", "allele"), sep = "\\.")
m_tag1=dcast(m_tag1, RSID + model~ allele)
m_tag2=dcast(m_tag2, RSID + model~ allele)

#assign labels to tag + top 5 snps 

m_tag1$label=""
m_tag2$label=""
#EUR
#m_tag1$label[m_tag1$RSID=="rs9526201"]="rs9526201"
#m_tag1$label[m_tag1$RSID=="rs9534444"]="rs9534444"
#m_tag1$label[m_tag1$RSID=="rs1142184"]="rs1142184"
#m_tag1$label[m_tag1$RSID=="rs7983898"]="rs7983898"
#m_tag1$label[m_tag1$RSID=="rs9316222"]="rs9316222"

#m_tag2$label[m_tag2$RSID=="rs3802177"]="rs3802177"
#m_tag2$label[m_tag2$RSID=="rs11558471"]="rs11558471"
#m_tag2$label[m_tag2$RSID=="rs28529793"]="rs28529793"


#EAS
m_tag1$label[m_tag1$RSID=="rs9526201"]="rs9526201"
m_tag1$label[m_tag1$RSID=="rs9316222"]="rs9316222"
m_tag1$label[m_tag1$RSID=="rs56058552"]="rs56058552"
m_tag1$label[m_tag1$RSID=="rs9526209"]="rs9526209"
m_tag1$label[m_tag1$RSID=="rs1408224"]="rs1408224"
m_tag1$label[m_tag1$RSID=="rs142306868"]="rs142306868"

m_tag2$label[m_tag2$RSID=="rs3802177"]="rs3802177"
m_tag2$label[m_tag2$RSID=="rs11558471"]="rs11558471"
m_tag2$label[m_tag2$RSID=="rs28529793"]="rs28529793"


options(repr.plot.width=10, repr.plot.height=8)
p1=ggplot(data=m_tag1,
       aes(x=ref,
           y=alt,
           group=model,
           color=model))+
  geom_point(alpha=0.5)+
  geom_abline()+
  xlim(-4.5,4.5)+
  ylim(-4.5,4.5)+
  theme_bw(20)+
  ggtitle("SVM model preds for REF and ALT alelles\nfor Diabetes LD SNPs rs9526201, EAS")+
  scale_color_manual(name='Model',values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'),labels=c("COLO205","Healthy","Tumor","HCT116","SW480"))+
  theme(legend.position = "bottom")

p2=ggplot(data=m_tag2,
       aes(x=ref,
           y=alt,
           group=model,
           color=model))+
  geom_point(alpha=0.5)+
  geom_abline()+
  xlim(-4.5,4.5)+
  ylim(-4.5,4.5)+
  theme_bw(20)+
  ggtitle("SVM model preds for REF and ALT alelles\nfor Diabetes LD SNPs rs3802177, EAS")+
  scale_color_manual(name='Model',values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'),labels=c("COLO205","Healthy","Tumor","HCT116","SW480"))+
  theme(legend.position = "bottom")

source('~/helpers.R')
multiplot(p1,p2,cols=2)



m_tag1_filtered=m_tag1[m_tag1$label!="",]
m_tag2_filtered=m_tag2[m_tag2$label!="",]

p3=ggplot(data=m_tag1_filtered,
       aes(x=ref,
           y=alt,
           group=model,
           color=model,
           label=label))+
  geom_point(alpha=0.5)+
  geom_abline()+
  geom_text(fontface = "bold",alpha=0.3,position=position_jitter(width=.5,height=.5))+
  xlim(-4.5,4.5)+
  ylim(-4.5,4.5)+
  theme_bw(30)+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'),
                     labels=c("COLO205","Healthy","Tumor","HCT116","SW480"))+
  theme(legend.position = "bottom")


p4=ggplot(data=m_tag2_filtered,
          aes(x=ref,
              y=alt,
              group=model,
              color=model,
              label=label))+
  geom_point(alpha=0.5)+
  geom_abline()+
  geom_text(fontface = "bold",alpha=0.3,position=position_jitter(width=.5,height=.5))+
  xlim(-4.5,4.5)+
  ylim(-4.5,4.5)+
  theme_bw(30)+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'),
                     labels=c("COLO205","Healthy","Tumor","HCT116","SW480"))+
  theme(legend.position = "bottom")

multiplot(p3,p4,cols=2)
