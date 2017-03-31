rm(list=ls())
library(data.table)
data=data.frame(read.table("pca.small.input.tsv",header=T,sep='\t'))
data$rs=NULL 
data$ref=NULL  
data$alt=NULL 
data$group=NULL 
#data=scale(data)
data.pca=prcomp(data,scale.=TRUE,center=TRUE) 
#browser() 
png('pca_non_cell_type_specific.png',height=831,width=1755)
par(mfrow=c(1,3))
biplot(data.pca,cex=2,choices=c(1,2),scale=0,xlabs=rep(".",nrow(data)))#,ylabs=rep("",ncol(data)))
biplot(data.pca,cex=2,choices=c(2,3),scale=0,xlabs=rep(".",nrow(data)))#,ylabs=rep("",ncol(data)))
biplot(data.pca,cex=2,choices=c(1,3),scale=0,xlabs=rep(".",nrow(data)))#,ylabs=rep("",ncol(data)))

#biplot(data.pca,cex=2,choices=c(1,2),scale=0,xlabs=rep(".",nrow(data)),ylabs=rep("",ncol(data)))
#biplot(data.pca,cex=2,choices=c(2,3),scale=0,xlabs=rep(".",nrow(data)),ylabs=rep("",ncol(data)))
#biplot(data.pca,cex=2,choices=c(1,3),scale=0,xlabs=rep(".",nrow(data)),ylabs=rep("",ncol(data)))
dev.off() 
#browser() 
par(mfrow=c(1,1))
png('pca_non_cell_type_specific.scree.png')
pr.all.var=data.pca$sdev^2 
pve.all=pr.all.var/sum(pr.all.var) 
plot(pve.all,xlab="Principal Component for All-Features",ylab="Proportion of Variance Explained",ylim=c(0,1),type="b") 
dev.off()  
#write.csv(data.pca$x[,1:30],file="pca.input.first30comp.txt",sep='\t')