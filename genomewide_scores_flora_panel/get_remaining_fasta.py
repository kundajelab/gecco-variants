import argparse
def parse_args(): 
    parser=argparse.ArgumentParser(description="get remaining fasta seqs")
    parser.add_argument("--last_parsed") 
    parser.add_argument("--fasta")
    parser.add_argument("--splits",type=int,default=1,help="number of chunks to use for gkmexplain")
    parser.add_argument("--out") 
    return parser.parse_args() 

def main(): 
    args=parse_args() 
    last_parsed=open(args.last_parsed,'r').read().strip().split('\n')[0] 
    print(last_parsed)
    fasta=[i.split('\n') for i in open(args.fasta,'r').read().strip().split('>')] 
    print("loaded fasta") 
    print(str(len(fasta)))
    found=False 
    for i in range(len(fasta)): 
        #print(fasta[i][0])
        if fasta[i][0]==last_parsed: 
            found=True
            break 
    assert found==True 
    outputs={} 
    for out_index in range(args.splits): 
        outputs[out_index]=open(args.out+"."+str(out_index),'w')
    for j in range(i+1,len(fasta)): 
        header='>'+fasta[j][0] 
        seq=fasta[j][1] 
        cur_output_index=j%args.splits 
        outputs[cur_output_index].write(header+'\n'+seq+'\n')
    for out_index in range(args.splits): 
        outputs[out_index].close() 
    
        
    

if __name__=="__main__": 
    main() 

