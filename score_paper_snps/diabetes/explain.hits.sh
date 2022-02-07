#!/bin/bash
model_prefix=/oak/stanford/groups/akundaje/projects/GECCO/SVM/models
for cell_line in dnase_c dnase_v hct116 colo205 sw480
do

  #  gkmexplain diabetes.9.ref.fa $model_prefix/model.$cell_line.9.model.txt gkmexplain.$cell_line.diabetes.9.ref.txt &
  #  gkmexplain diabetes.9.alt.fa $model_prefix/model.$cell_line.9.model.txt gkmexplain.$cell_line.diabetes.9.alt.txt &
  #  gkmexplain diabetes.3.ref.fa $model_prefix/model.$cell_line.3.model.txt gkmexplain.$cell_line.diabetes.3.ref.txt &
  #  gkmexplain diabetes.3.alt.fa $model_prefix/model.$cell_line.3.model.txt gkmexplain.$cell_line.diabetes.3.alt.txt &
    gkmexplain calcium.hits.ref.fa $model_prefix/model.$cell_line.1.model.txt gkmexplain.$cell_line.calcium.hits.ref.txt &
    gkmexplain calcium.hits.alt.fa $model_prefix/model.$cell_line.1.model.txt gkmexplain.$cell_line.calcium.hits.alt.txt &
    
done

