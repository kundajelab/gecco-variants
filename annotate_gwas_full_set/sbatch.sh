for chrom in `seq 1 22` 
do 
    sbatch -J $chrom -o logs/$chrom.o -e logs/$chrom.e -p akundaje,owners --mem=10000 annotate_gwas.sh $chrom
done
