model_prefix=/oak/stanford/groups/akundaje/projects/GECCO/alcohol/models
split=9
for cell_line in dnase_c dnase_v hct116 colo205 sw480
do    
    ./predict.sh cox15.ref.fa $model_prefix/model.$cell_line.$split.model.txt ref.pred.$cell_line.txt &
    ./predict.sh cox15.alt.fa $model_prefix/model.$cell_line.$split.model.txt alt.pred.$cell_line.txt &
done
