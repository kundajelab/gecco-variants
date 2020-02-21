#!/bin/bash
prefix=/oak/stanford/groups/akundaje/projects/ENCODE_scATAC/cellranger/v.1.2.0
suffix=outs/fragments.tsv.gz
zcat $prefix/*COLM*/$suffix > COLM.fragments.bed &
zcat $prefix/*COLL*/$suffix > COLL.fragments.bed &
zcat $prefix/*MODC*/$suffix > MODC.fragments.bed &


