#!/bin/bash
align_dir=/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/aligned
chromsizes_file=/mnt/data/annotations/by_release/hg38/hg38.chrom.sizes
snap_dir=/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/snap
for sample in scATAC_W72_COLL_B_10922_X015_S06_B1_T1_S13 scATAC_W61_COLM_B_8817_X006_S08_B1_T1 scATAC_W73_COLL_B_10923_X005_S08_B1_T1_S16 scATAC_W62_COLM_B_8850_X004_S08_B1_T1_S3 scATAC_W76_MODC_B_10931_X016_S03_B1_T1 scATAC_W64_MODC_B_10910_X016_S02_B1_T1_S15 scATAC_W80_MODC_B_10947_X017_S01_B1_T1_S22
do
    ./make_snap.sh $chromsizes_file $sample $align_dir $snap_dir
done
