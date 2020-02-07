### demultiplex 10X FILES ###
sample=$1
sample_folder=$2
outdir=$3

in=$sample_folder/$sample
out=$outdir/$sample

mkdir -p $outdir
for lane in `seq 1 4`
do
    snaptools dex-fastq --input=$in\_L00$lane\_R1_001.fastq.gz --output-fastq=$out\_L00$lane\_R1.dex.fastq.gz --index-fastq-list=$in\_L00$lane\_R2_001.fastq.gz &
    snaptools dex-fastq --input=$in\_L00$lane\_R3_001.fastq.gz --output-fastq=$out\_L00$lane\_R3.dex.fastq.gz --index-fastq-list=$in\_L00$lane\_R2_001.fastq.gz &
done
 
