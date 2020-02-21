#get the inverse intersection of idr peak file and all gc genome bins
bedtools intersect -v -a /srv/scratch/annashch/5_cell_lines_bias_correction/genomewide_gc/gc_hg38_nosmooth.tsv -b COLM.idr.optimal_peak.summits.max.signal.narrowPeak > COLM.candidate.negatives.tsv
