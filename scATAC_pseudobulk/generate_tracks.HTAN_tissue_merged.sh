prefix=/oak/stanford/groups/akundaje/projects/GECCO/scATAC/HTAN/aggregate_tissue_merged/
python generate_tracks.py --pval_bigwigs $prefix/pval.bigwig \
    --fc_bigwigs $prefix/fc.bigwig \
    --outf_fc_bigwig htan_pseudobulk_tissue_merged_fc_bigwig.json \
    --outf_pval_bigwig htan_pseudobulk_tissue_merged_pval_bigwig.json \
    --mitra_prefix http://mitra.stanford.edu/kundaje/projects \
    --prefix_to_drop_for_oak /oak/stanford/groups/akundaje/projects





