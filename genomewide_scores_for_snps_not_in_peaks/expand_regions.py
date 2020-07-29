import sys
import pandas as pd
input_df=sys.argv[1]
flank=int(sys.argv[2])
output_df=sys.argv[3]
data=pd.read_csv(input_df,header=None,sep='\t')
print(data.head())
data[2]=data[1]+flank
data[1]=data[1]-flank
print(data.head())
data.to_csv(output_df,index=False,header=False,sep='\t')
