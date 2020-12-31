#!/bin/bash
model_prefix=/oak/stanford/groups/akundaje/projects/GECCO/alcohol/models
for task in dnase_c dnase_v hct116 colo205 sw480
do
    gkmexplain cox15.ref.tointerpret.fa $model_prefix/model.$task.9.model.txt gkmexplain.ref.cox15.$task.txt &
    gkmexplain cox15.alt.tointerpret.fa $model_prefix/model.$task.9.model.txt gkmexplain.alt.cox15.$task.txt &
    
done
