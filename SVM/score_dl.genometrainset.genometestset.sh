mkdir dl.perf.genometrainset.genometestset
prefix=/srv/scratch/annashch/deeplearning/gecco/gc_corrected/classification
python score_dl.py \
       --multitask \
       --predictions_hdf5 $prefix/classification.predictions.gc.0.predictions.0 $prefix/classification.predictions.gc.1.predictions.0 $prefix/classification.predictions.gc.2.predictions.0 $prefix/classification.predictions.gc.3.predictions.0 $prefix/classification.predictions.gc.4.predictions.0 $prefix/classification.predictions.gc.5.predictions.0 $prefix/classification.predictions.gc.6.predictions.0 $prefix/classification.predictions.gc.7.predictions.0 $prefix/classification.predictions.gc.8.predictions.0 $prefix/classification.predictions.gc.9.predictions.0 \
       --labels_hdf5 $prefix/classification.predictions.gc.0.labels.0 $prefix/classification.predictions.gc.1.labels.0 $prefix/classification.predictions.gc.2.labels.0 $prefix/classification.predictions.gc.3.labels.0 $prefix/classification.predictions.gc.4.labels.0 $prefix/classification.predictions.gc.5.labels.0 $prefix/classification.predictions.gc.6.labels.0 $prefix/classification.predictions.gc.7.labels.0 $prefix/classification.predictions.gc.8.labels.0 $prefix/classification.predictions.gc.9.labels.0 \
       --outf dl.perf.genometrainset.genometestset/
