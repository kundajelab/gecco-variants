#!/bin/bash
for i in `seq 0 9`
do
    python make_bed_from_hdf.py $i &
done
