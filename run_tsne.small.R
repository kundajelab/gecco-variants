rm(list=ls())
library(data.table)
library(Rtsne) 
data=data.frame(read.table("pca.small.input.trimmed.tsv",header=T,sep='\t'))
data=scale(data)
tsne_out <- Rtsne(as.matrix(data),perplexity=150) # Run TSNE
save(tsne_out,file="tSNE.small.RData") 
png('tsne.small.png',height=831,width=1755)
plot(tsne_out$Y,type = 'p', col = 'black', pch=16)
dev.off() 


