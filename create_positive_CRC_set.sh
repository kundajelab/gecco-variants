rm tmp
#concatenate all H3K27ac narrowPeak files 
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V429_H3K27ac.nodup.tagAlign_x_V429_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort >>tmp 
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V9P_H3K27ac.nodup.tagAlign_x_V9P_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V855_H3K27ac.nodup.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V5_H3K27ac.nodup.tagAlign_x_V5_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V457_H3K27ac.nodup.tagAlign_x_V457_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V703_H3K27ac.nodup.tagAlign_x_V703_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V968_H3K27ac.nodup.tagAlign_x_V968_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V456_H3K27ac.nodup.tagAlign_x_V456_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V432_H3K27ac.nodup.tagAlign_x_V432_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V940_H3K27ac.nodup.tagAlign_x_V940_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V410_H3K27ac.nodup.tagAlign_x_V410_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/C37_H3K27ac.nodup.tagAlign_x_C37_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V1051_H3K27ac.nodup.tagAlign_x_V1051_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V1009_H3K27ac.nodup.tagAlign_x_V1009_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V206_H3K27ac.nodup.tagAlign_x_V206_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V481_H3K27ac.nodup.tagAlign_x_V481_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V784_H3K27ac.nodup.tagAlign_x_V784_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V852_H3K27ac.nodup.tagAlign_x_V852_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V1024_H3K27ac.nodup.tagAlign_x_V1024_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V576_H3K27ac.nodup.tagAlign_x_V576_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V866_H3K27ac.nodup.tagAlign_x_V866_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/C29_H3K27ac.nodup.tagAlign_x_C29_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/C28_H3K27ac.nodup.tagAlign_x_C28_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
cat /srv/www/kundaje/annashch/gecco/H3K27ac/bed/V411_H3K27ac.nodup.tagAlign_x_V411_Input.nodup.tagAlign.naive_overlap.narrowPeak.filtered.noshort  >> tmp
bedtools sort -i tmp  | cut -f1,2,3 > H3K27ac_concatenated.bed

echo "got H3K27ac_concatenated.bed"
#concatenate DNAse files
rm tmp 
cat /srv/www/kundaje/annashch/gecco/DNase/bed/V410.bed >>tmp
cat /srv/www/kundaje/annashch/gecco/DNase/bed/C34.bed  >> tmp
cat /srv/www/kundaje/annashch/gecco/DNase/bed/V389.bed >> tmp
cat /srv/www/kundaje/annashch/gecco/DNase/bed/C36.bed  >> tmp
cat /srv/www/kundaje/annashch/gecco/DNase/bed/V576.bed >> tmp
cat /srv/www/kundaje/annashch/gecco/DNase/bed/C31.bed  >> tmp
bedtools sort -i tmp | cut -f1,2,3 > DNAse_concatenated.bed 
echo "got DNAse_concatenated.bed"
#concatenate the gecco DNAse peaks with the encode peaks
cat DNAse_concatenated.bed encode-roadmap.dnase.master.bed | bedtools sort | cut -f1,2,3 > GECCO_Plus_ENCODE_DNase.bed
echo "got GECCO_Plus_ENCODE_DNase.bed"
#keep H3K27ac peaks that intersect w/ ENCODE/GECCO DNAse merged set
bedtools intersect -a H3K27ac_concatenated.bed -b GECCO_Plus_ENCODE_DNase.bed| bedtools sort | uniq  > H3K27ac_surviving.bed 
echo "got H3K27ac_surviving.bed" 

#cat gecco DNAse w/ surviving H3K27ac peaks to get a positive set from CRC data
cat H3K27ac_surviving.bed DNAse_concatenated.bed > positive_crc.bed 
echo "got positive_crc.bed" 
#sort the positive crc file 
bedtools sort -i positive_crc.bed | uniq >tmp
bedtools merge -i tmp > positive_crc.merged.bed

echo "sorted positive_crc.bed" 
#format allele frequencies as bed file 
python format_allele_counts_as_bed.py
echo "got bed-formatted alleles"
#intersect allele counts w/ positive CRC set
bedtools intersect -wao -a positive_crc.merged.bed -b allele_counts_500_subjects.bed >  positive_maf_intersection.bed
echo "got intersection of allele_counts_500_subjects and positive_crc"

#get tallies of allele counts by frequency & number of positive regions sampled
python tally_freq_counts.py
