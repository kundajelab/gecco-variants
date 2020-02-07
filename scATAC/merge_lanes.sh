#merge demultiplexed L001 - L004 lanes 
sample=$1
indir=$2
in=$indir/$sample

#rm $in\_R1.dex.fastq.gz
#rm $in\_R3.dex.fastq.gz

cat $in\_L001_R1.dex.fastq.gz $in\_L002_R1.dex.fastq.gz $in\_L003_R1.dex.fastq.gz $in\_L004_R1.dex.fastq.gz > $in\_R1.dex.fastq.gz & 
cat $in\_L001_R3.dex.fastq.gz $in\_L002_R3.dex.fastq.gz $in\_L003_R3.dex.fastq.gz $in\_L004_R3.dex.fastq.gz > $in\_R3.dex.fastq.gz &
