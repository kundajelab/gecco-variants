#for f in `ls svm.inputs/*test*`
for f in `ls svm.inputs/*train*`
do
    grep ">" $f | sed --expression='s/>//g' | sed --expression='s/\_/\t/g' > $f.bed
done
