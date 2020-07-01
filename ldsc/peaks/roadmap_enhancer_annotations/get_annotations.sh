basedir=/oak/stanford/groups/akundaje/refs/epigenomeRoadmap/chromhmmSegmentations/ChmmModels/coreMarks/jointModel/final
for i in $basedir/*coreMarks_mnemonics.bed.gz
do
    fname=`basename $i`
    zgrep "Enh" $i > Enh.$fname
    echo $i
done

														   
