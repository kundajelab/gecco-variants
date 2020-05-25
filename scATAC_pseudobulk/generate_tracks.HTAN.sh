prefix=/oak/stanford/groups/akundaje/projects/GECCO/scATAC/HTAN/aggregate/
python generate_tracks.py --pval_bigwigs $prefix/pval.bigwig \
    --fc_bigwigs $prefix/fc.bigwig \
    --outf_fc_bigwig htan_pseudobulk_fc_bigwig.json \
    --outf_pval_bigwig htan_pseudobulk_pval_bigwig.json \
    --mitra_prefix http://mitra.stanford.edu/kundaje/projects \
    --prefix_to_drop_for_oak /oak/stanford/groups/akundaje/projects





