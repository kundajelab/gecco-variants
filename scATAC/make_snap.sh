### PREPARE 10X FILES ###
#make snap file 
chromsizes_file=$1
sample=$2
input_folder=$3
output_folder=$4
snaptools snap-pre  --input-file=$input_folder/$sample.bam  --output-snap=$output_folder/$sample.snap  --genome-name=hg38  --genome-size=$chromsizes_file  \
    --min-mapq=30  --min-flen=25  --max-flen=1000  --keep-chrm=TRUE  --keep-single=TRUE  --keep-secondary=False  \
    --overwrite=True  --max-num=1000000  --min-cov=10  --verbose=True
#binning 
snaptools snap-add-bmat --snap-file=$output_folder/$sample.snap --bin-size-list 50 1000 2000 5000 10000 --verbose=True 
