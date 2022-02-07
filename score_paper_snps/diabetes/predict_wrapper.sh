model_prefix=/oak/stanford/groups/akundaje/projects/GECCO/SVM/models
for cell_line in dnase_c dnase_v hct116 colo205 sw480
do
    for ancestry in EUR EAS
    do
	./predict.sh $ancestry.diabetes.9.ref.fa $model_prefix/model.$cell_line.9.model.txt $ancestry.pred.$cell_line.diabetes.9.ref.txt &
	./predict.sh $ancestry.diabetes.9.alt.fa $model_prefix/model.$cell_line.9.model.txt $ancestry.pred.$cell_line.diabetes.9.alt.txt &
	./predict.sh $ancestry.diabetes.3.ref.fa $model_prefix/model.$cell_line.3.model.txt $ancestry.pred.$cell_line.diabetes.3.ref.txt &
	./predict.sh $ancestry.diabetes.3.alt.fa $model_prefix/model.$cell_line.3.model.txt $ancestry.pred.$cell_line.diabetes.3.alt.txt &
    done
done
