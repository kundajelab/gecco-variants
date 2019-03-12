#!/bin/bash
$HOME/ensembl-vep/vep -i x$1 --output_file $1.vep --fork 16  --port 3337 --plugin PolyPhen_SIFT --cache 
