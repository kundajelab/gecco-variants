for fold in `seq 0 9`
do
    python expand_regions.py $fold.gecco.snps.not.in.dnase.peaks.bed 500 $fold.gecco.snps.not.in.dnase.peaks.1kb.bed &
done
