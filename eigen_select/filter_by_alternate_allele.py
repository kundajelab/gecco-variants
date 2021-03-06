#Filters the eigen results to include observed alternate alleles 
out_dir_eigen="eigen_hits_allele_filtered/" 
out_dir_pca="eigen_pca_hits_allele_filtered/" 

reference=open('basset_input.bed','r').read().split('\n') 
while '' in reference: 
    reference.remove('') 
ref_dict=dict() 
for line in reference: 
    tokens=line.split('\t') 
    chrom=tokens[0].replace('chr','') 
    pos=tokens[1] 
    ref=tokens[3][0] 
    alt=tokens[4][0]  
    ref_dict[tuple([chrom,pos])]=[ref,alt] 
    
for i in range(1,23): 
    #process file for each chromosome! 
    out_eigen=open(out_dir_eigen+"chr"+str(i)+".bed",'w')
    out_eigen_pca=open(out_dir_pca+"chr"+str(i)+".pca.bed",'w') 
    data=open('eigen_hits/chr'+str(i)+".eigen.bed",'r').read().split('\n') 
    while '' in data: 
        data.remove('') 
    data_pca=open('eigen_pca_hits/chr'+str(i)+'.eigen.pca.bed','r').read().split('\n') 
    while '' in data_pca: 
        data_pca.remove('') 
    for line in data: 
        tokens=line.split('\t') 
        chrom=tokens[0] 
        pos=tokens[1] 
        ref=tokens[2] 
        alt=tokens[3] 
        entry=tuple([chrom,pos]) 
        ref_expected=ref_dict[entry][0] 
        if ref_expected!=ref: 
            print str(line)+" expected reference:"+str(ref_expected) 
        elif alt==ref_dict[entry][1]: 
            out_eigen.write(line+'\n') 
    print "processed eigen entry" 
    for line in data_pca: 
        tokens=line.split('\t') 
        chrom=tokens[0] 
        pos=tokens[1] 
        ref=tokens[2] 
        alt=tokens[3] 
        entry=tuple([chrom,pos]) 
        ref_expected=ref_dict[entry][0] 
        if alt==ref_dict[entry][1]: 
            out_eigen_pca.write(line+'\n') 
    print "processed eigen pca entry" 
        
            
    
