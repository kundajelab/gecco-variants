#intersects credible set annotation with annotation from screen
annotations=open("annotation.txt",'r').read().strip().split('\n')
screen_annotations=open("../cred_set/all.annotated","r").read().strip().split("\n") 
outf=open("annotations_with_screen.txt",'w')
annotation_dict=dict()
outf.write(annotations[0]+'\t'+screen_annotations[0]+"\n")
anno_dict=dict() 
for line in annotations[1:]:
    tokens=line.split('\t')
    var=tokens[3]
    anno_dict[var]=line
for line in screen_annotations[1::]:
    tokens=line.split('\t')
    var=tokens[0]
    try:
        anno_dict[var]=anno_dict[var]+'\t'+line
    except:
        var_subset=var.split('_')[0]
        found=False
        for key in anno_dict.keys():
            key_subset=key.split('_')[0]
            if var_subset==key_subset:
                anno_dict[key]=anno_dict[key]+'\t'+line
                found=True
                break
        if(found==False):
            print(var)
outf.write('\n'.join(list(anno_dict.values()))+'\n')
