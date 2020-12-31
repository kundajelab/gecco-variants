rm(list=ls())
library(ggplot2)
source("~/helpers.R")
data=read.table("aggregate_performance_for_plot.tsv",header=TRUE,sep='\t')
# columns to paste together
cols <- c( 'Model' , 'TrainSet' , 'TestSet' )

# create a new column `x` with the three columns collapsed together
data$Experiment <- apply( data[ , cols ] , 1 , paste , collapse = "-" )
data$Experiment=factor(data$Experiment,levels=c("SVM-SVM-Genome",
                                                "CNN-SVM-Genome",
                                                "CNN-Genome-Genome",
                                                "SVM-SVM-SVM",
                                                "CNN-Genome-SVM",
                                                "CNN-SVM-SVM"))
data=data[order(data$Experiment),]
attach(data)
p1=ggplot(data, aes(x = Task,y=auPRC,fill=Task)) +
  geom_boxplot() +
  geom_jitter(color='black',shape = 21)+
  facet_grid(.~Experiment)+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'))+
  theme_bw(10)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  ggtitle("Model - Training Set - Test Set")


#split by model 
cnn_gen_gen=data[data$Experiment=="CNN-Genome-Genome",]
cnn_gen_svm=data[data$Experiment=="CNN-Genome-SVM",]
cnn_svm_svm=data[data$Experiment=="CNN-SVM-SVM",]
cnn_svm_gen=data[data$Experiment=="CNN-SVM-Genome",]
svm_svm_svm=data[data$Experiment=="SVM-SVM-SVM",]
svm_svm_gen=data[data$Experiment=="SVM-SVM-Genome",]

p2=ggplot(data=cnn_gen_gen,
       aes(x=Task,y=auPRC,fill=Task))+
  geom_boxplot()+
  geom_jitter(color='black',shape=21)+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'))+
  theme_bw(10)+
  ggtitle("CNN\nGenomewide Train\nGenomewide Test")+
  theme(legend.position="none")+
  ylim(0,1)+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

p3=ggplot(data=cnn_gen_svm,
          aes(x=Task,y=auPRC,fill=Task))+
  geom_boxplot()+
  geom_jitter(color='black',shape=21)+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'))+
  theme_bw(10)+
  ggtitle("CNN\nGenomewide Train\nGC-Balanced Test")+
  theme(legend.position="none")+
  ylim(0,1)+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

p4=ggplot(data=cnn_svm_gen,
          aes(x=Task,y=auPRC,fill=Task))+
  geom_boxplot()+
  geom_jitter(color='black',shape=21)+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'))+
  theme_bw(10)+
  ggtitle("CNN\nGC-Balanced Train\nGenomewide Test")+
  theme(legend.position="none")+
  ylim(0,1)+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

p5=ggplot(data=cnn_svm_svm,
          aes(x=Task,y=auPRC,fill=Task))+
  geom_boxplot()+
  geom_jitter(color='black',shape=21)+
  scale_fill_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00'))+
  theme_bw(10)+
  ggtitle("CNN\nGC-Balanced Train\nGC-Balanced Test")+
  theme(legend.position="none")+
  ylim(0,1)+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

multiplot(p2,p3,p4,p5,cols=2)