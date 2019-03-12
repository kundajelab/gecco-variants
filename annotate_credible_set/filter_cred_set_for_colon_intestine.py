data=open('annotations_with_screen.txt','r').read().strip().split('\n')
outf=open('annotations_with_screen.txt.new','w')
outf.write(data[0]+'\t'+'HCT116_likely\n')
for line in data[1::]:
    if 'intestine' in line:
        outf.write(line+'\t1\n')
    elif 'colon' in line:
        outf.write(line+'\t1\n')
    elif 'hct' in line:
        outf.write(line+'\t1\n')
    elif 'HCT' in line:
        outf.write(line+'\t1\n')
    elif 'rect' in line:
        outf.write(line+'\t1\n')
    else:
        outf.write(line+'\t0\n')
        
