#python get_most_significant_summit_and_ambig_regions.py --narrowPeak idr.optimal_peak.sorted.narrowPeak  --outf idr.optimal_peak.narrowPeak.summits.max.signal
for sample in COLL COLM MODC
do
    python get_most_significant_summit_and_ambig_regions.py --narrowPeak $sample/$sample.idr.optimal_peak.sorted.narrowPeak  --outf $sample/$sample.idr.optimal_peak.narrowPeak.summits.max.signal
done
