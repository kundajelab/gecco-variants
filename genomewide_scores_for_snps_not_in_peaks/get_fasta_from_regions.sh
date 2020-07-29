for split in `seq 0 9`
do
    echo $split
    fastaFromBed -fi /mnt/data/male.hg19.fa -nameOnly -bed $split.gecco.snps.not.in.dnase.peaks.1kb.bed -fo $split.gecco.snps.not.in.dnase.peaks.1kb.fa &
done
