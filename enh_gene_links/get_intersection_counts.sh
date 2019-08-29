echo "distinct tss with prox enhancer:"
for i in *intersection*bed
do
    echo "$i" `cut -f1,4 $i | sort | uniq | wc -l`
done
echo "distinct gene with prox enhancer:"
for i in *intersection*bed
do
    echo "$i" `cut -f6 $i | sort | uniq | wc -l`
done

echo "distinct enhancer with prox tss:"
for i in *intersection*bed
do
    echo "$i" ` cut -f8,9,10 $i | sort | uniq | wc -l`
done
