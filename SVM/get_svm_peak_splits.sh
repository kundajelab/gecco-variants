python get_svm_peak_splits.py \
       --narrowPeak C_merged_bam_rep1-pr.naive_overlap.filt.narrowPeak.gz \
       --ntrain 60000 \
       --out_prefix svm.peaks.C_merged \
       --genome hg19

python get_svm_peak_splits.py \
       --narrowPeak V_merged_bam_rep1-pr.naive_overlap.filt.narrowPeak.gz \
       --ntrain 60000 \
       --out_prefix svm.peaks.V_merged \
       --genome hg19 &

python get_svm_peak_splits.py \
       --narrowPeak colo205_rep1-pr.naive_overlap.filt.narrowPeak.gz \
       --ntrain 60000 \
       --out_prefix svm.peaks.colo205 \
       --genome hg19 &

python get_svm_peak_splits.py \
       --narrowPeak sw480_ppr.naive_overlap.filt.narrowPeak.gz \
       --ntrain 60000 \
       --out_prefix svm.peaks.sw480 \
       --genome hg19 &

python get_svm_peak_splits.py \
       --narrowPeak hct116_rep1-rep2.naive_overlap.filt.narrowPeak.gz \
       --ntrain 60000 \
       --out_prefix svm.peaks.hct116 \
       --genome hg19 &





