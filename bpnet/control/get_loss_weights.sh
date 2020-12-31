kerasAC_loss_weights_bpnet --tdb_array /srv/scratch/annashch/gecco/tiledb/db \
                            --chroms chr1 \
                            --upsample_attribute overlap_peak \
                            --label_attribute count_bigwig_unstranded_5p \
                            --num_threads 1 \
                            --task CONTROL \
                            --upsample_thresh 1 \
                            --flank 500
