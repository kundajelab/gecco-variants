python generate_tracks.py --pval_bigwigs /scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/aggregate_outputs/outputs/nodup.pval.signal.bigwig.filtered \
    --fc_bigwigs /scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/aggregate_outputs/outputs/nodup.fc.signal.bigwig.filtered \
    --hammocks /scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/aggregate_outputs/outputs/hammock.files.txt.filtered \
    --sample_index 9 \
    --outf_fc_bigwig scacheri_46_h3k27ac_chipseq_fc_bigwig.json \
    --outf_pval_bigwig scacheri_46_h3k27ac_chipseq_pval_bigwig.json \
    --mitra_prefix http://mitra.stanford.edu/kundaje/projects/GECCO/ \
    --prefix_to_drop_for_oak /oak/stanford/groups/akundaje/projects/GECCO/

