#!/bin/bash
python make_plots.py --tasks healthy tumor sw480 hct116 colo205 \
       --ref_files \
       --alt_files \
       --snps \
       --ylim 0.05
