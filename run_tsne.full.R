rm(list=ls())
library(data.table)
library(Rtsne) 
data=data.frame(read.table("pca.input.first30comp.txt",header=T,sep='\t'))
data=scale(data)
tsne_out <- Rtsne(as.matrix(data),perplexity=150) # Run TSNE
save(tsne_out,file="tSNE.full.RData") 
png('tsne.full.png',height=831,width=1755)
plot(tsne_out$Y,type='p',col='black',pch=16)
dev.off() 


