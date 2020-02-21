rm(list=ls())
library(SnapATAC)
x.sp = createSnap(
  file="scATAC_W62_COLM_B_8850_X004_S08_B1_T1_S3.snap",
  sample="scATAC_W62_COLM_B_8850_X004_S08_B1_T1_S3",
  num.cores=50)
barcodes = read.csv(
  "singlecell.csv",
  head=TRUE)
barcodes = barcodes[2:nrow(barcodes),]