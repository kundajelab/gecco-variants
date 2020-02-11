rm(list=ls())
library(ggplot2)
data=read.table("aggregate_performance.tsv",header=TRUE,sep='\t')
# columns to paste together
cols <- c( 'Model' , 'TrainSet' , 'TestSet' )

# create a new column `x` with the three columns collapsed together
data$Experiment <- apply( data[ , cols ] , 1 , paste , collapse = "-" )

attach(data)
p1=ggplot(data, aes(x = Fold,y=auPRC,group=Experiment,linetype=Model,color=Experiment)) +
  geom_line() +
  geom_point()+
  facet_wrap(vars(Task),ncol = 5)+
  scale_linetype_manual(values=c("solid","dashed"))+
  scale_color_manual(values=c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#ffff33'))+
  scale_x_continuous(name="Fold",breaks=seq(0,9),labels=seq(0,9))+
  theme(legend.position="bottom")+
  theme_bw(10)

  