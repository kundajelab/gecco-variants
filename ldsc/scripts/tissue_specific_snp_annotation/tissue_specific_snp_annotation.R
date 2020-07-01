library(data.table)
library(foreach)
library(doMC)
registerDoMC(20)
library(stringr)

args = commandArgs(trailingOnly=TRUE)
tissues=as.vector(read.table(args[1],header=FALSE)$V1)
print(tissues) 
peak_dir = args[2]
out_dir =  args[3]
plink_dir = "/mnt/data/ldscore/1000G_plinkfiles"


read_bim = function(plink_dir){
	bim_fn_list=list.files(plink_dir,'bim',full.names=TRUE)
	bim=foreach(i=seq_along(bim_fn_list),.combine='rbind')%dopar%{
		bim_fn=bim_fn_list[i]
		message(bim_fn)
		fread(bim_fn,select=1:4,col.names=c('CHR','SNP','CM','BP'))
	}
	return(bim)
}

annotate = function(bim,peak,tissues){
	annot = bim
	setcolorder(annot,c('CHR','BP','SNP','CM'))
	annot[,c('start','end'):=list(BP,BP)]
	setkey(annot,CHR, start, end)
	for (t in tissues){
		peak_t = peak[str_detect(tissue,t),]
		setkey(peak_t,chr,start,end)
		overlap = foverlaps(annot,peak_t,by.x = c('CHR','start','end'), by.y = c('chr','start','end'), nomatch = 0)
		annot[,new := as.integer(SNP %in% overlap$SNP)]
		setnames(annot,'new',t)
	}
	annot$start = NULL
	annot$end = NULL
	return(annot)
}


if (!dir.exists(out_dir)) {dir.create(out_dir)}
for (i in 1:length(tissues)){
	peak_fn = paste0(peak_dir, tissues[i])
	peak = fread(peak_fn,select = 1:3, col.names = c('chr','start','end'))
	peak$tissue = tissues[i]
	peak[,chr:=as.integer(str_replace(chr,'chr',''))]
	bim = read_bim(plink_dir)

	annot = annotate(bim,peak,tissues[i])

	for (j in 1:22){
		out = annot[CHR == j]
		out_fn = sprintf('%s/%s.chr%s.annot',out_dir,tissues[i],j)
		fwrite(out,out_fn,sep='\t')
	}
}

