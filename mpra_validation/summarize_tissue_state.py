def get_detailed_tallies(token,label,category,detailed_tallies): 
    token=token.split(';')
    if category not in detailed_tallies: 
        detailed_tallies[category]=dict() 
    if label not in detailed_tallies[category]: 
        detailed_tallies[category][label]=dict() 
    for part in token: 
        if part=="": 
            part="nan"
        if part not in detailed_tallies[category][label]: 
            detailed_tallies[category][label][part]=1
        else: 
            detailed_tallies[category][label][part]+=1
    return detailed_tallies 

def get_tallies(token,label,category,tallies):
    if ((token=="nan") or (token=="")): 
        if 1 not in tallies[category][label]: 
            tallies[category][label][1]=1 
        else: 
            tallies[category][label][1]+=1 
    elif "intestine" in token: 
        if token.count(";")<5: 
            if 2 not in tallies[category][label]: 
                tallies[category][label][2]=1 
            else: 
                tallies[category][label][2]+=1 
        else: 
            if 3 not in tallies[category][label]: 
                tallies[category][label][3]=1 
            else: 
                tallies[category][label][3]+=1
    else: 
        if token.count(";")<5: 
            if 4 not in tallies[category][label]: 
                tallies[category][label][4]=1 
            else: 
                tallies[category][label][4]+=1 
        else: 
            if 5 not in tallies[category][label]: 
                tallies[category][label][5]=1 
            else: 
                tallies[category][label][5]+=1
    return tallies

foreground=open("toplot.csv",'r').read().strip().split('\n') 
background=open("annotations.chr1.bed",'r').read().strip().split('\n') 
tallies=dict() 
detailed_tallies=dict() 
for line in foreground[1::]: 
    tokens=line.split('\t') 
    pls=tokens[-4]
    els=tokens[-3]
    ctcf=tokens[-2] 
    dnase=tokens[-1] 
    category=tokens[0] 
    if category not in tallies: 
        tallies[category]=dict() 
        tallies[category]['PLS']=dict() 
        tallies[category]['ELS']=dict() 
        tallies[category]['CTCF']=dict() 
        tallies[category]['DNASE']=dict() 
    tallies=get_tallies(pls,'PLS',category,tallies)
    tallies=get_tallies(els,'ELS',category,tallies) 
    tallies=get_tallies(ctcf,'CTCF',category,tallies) 
    tallies=get_tallies(dnase,'DNASE',category,tallies) 

    detailed_tallies=get_detailed_tallies(pls,'PLS',category,detailed_tallies)
    detailed_tallies=get_detailed_tallies(els,'ELS',category,detailed_tallies) 
    detailed_tallies=get_detailed_tallies(ctcf,'CTCF',category,detailed_tallies) 
    detailed_tallies=get_detailed_tallies(dnase,'DNASE',category,detailed_tallies) 
     
for line in background[1::]: 
    tokens=line.split('\t') 
    pls=tokens[-4]
    els=tokens[-3]
    ctcf=tokens[-2] 
    dnase=tokens[-1] 
    category="Background"
    if category not in tallies: 
        tallies[category]=dict() 
        tallies[category]['PLS']=dict() 
        tallies[category]['ELS']=dict() 
        tallies[category]['CTCF']=dict() 
        tallies[category]['DNASE']=dict() 
    tallies=get_tallies(pls,'PLS',category,tallies)
    tallies=get_tallies(els,'ELS',category,tallies) 
    tallies=get_tallies(ctcf,'CTCF',category,tallies) 
    tallies=get_tallies(dnase,'DNASE',category,tallies) 

    detailed_tallies=get_detailed_tallies(pls,'PLS',category,detailed_tallies)
    detailed_tallies=get_detailed_tallies(els,'ELS',category,detailed_tallies) 
    detailed_tallies=get_detailed_tallies(ctcf,'CTCF',category,detailed_tallies) 
    detailed_tallies=get_detailed_tallies(dnase,'DNASE',category,detailed_tallies) 


outf=open("summary_of_tissues_by_state.tsv",'w')
outf.write('Category\tState\tGroup\tCount\n')
for category in tallies: 
    for state in tallies[category]: 
        for group in tallies[category][state]: 
            value=str(tallies[category][state][group])
            outf.write(category+'\t'+state+'\t'+str(group)+'\t'+value+'\n')

outf=open("summary_of_tissues_by_state.detailed.tsv",'w')
outf.write('Category\tState\tTissue\tCount\n')
for category in detailed_tallies: 
    for state in detailed_tallies[category]: 
        for group in detailed_tallies[category][state]: 
            value=str(detailed_tallies[category][state][group])
            outf.write(category+'\t'+state+'\t'+str(group)+'\t'+value+'\n')
