for i in dnasec dnasev sw480 colo205 hct116
do
    gcloud compute instances create $i-1 $i-2 $i-3 $i-4 $i-5 $i-6 $i-7 $i-8 $i-9 --image lsgkm-predict --disk=name=gecco-svm,mode=ro,boot=no,auto-delete=no --zone us-central1-a --machine-type n1-standard-64
done
    

