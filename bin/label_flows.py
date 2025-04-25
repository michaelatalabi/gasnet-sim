import sys, pandas as pd
parquet, groundtruth_csv = sys.argv[1:3]
df = pd.read_parquet(parquet)
gt = pd.read_csv(groundtruth_csv)
labeled = df.merge(gt, on='run_id', how='left')
labeled.to_parquet(parquet.replace('.parquet', '_labeled.parquet'))
