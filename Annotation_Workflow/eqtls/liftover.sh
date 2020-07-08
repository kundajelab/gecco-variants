#!/bin/bash

INPUT_DIR=/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/example_input

/fh/fast/peters_u/Functional_Annotation/Annotation_Workflow/eqtls/liftOver $INPUT_DIR/ld_proxies_r2_80pct.bed  hg19ToHg38.over.chain.gz $INPUT_DIR/build38_ld_proxies_r2_80pct.bed $INPUT_DIR/unlifted.bed
