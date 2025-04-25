# placeholder script merging flows.csv with AirSim telemetry
import sys, pandas as pd, json

flows_csv, telemetry_json, out_parquet = sys.argv[1:4]
flows = pd.read_csv(flows_csv)
telemetry = pd.read_json(telemetry_json, lines=True)
merged = flows.merge(telemetry, on='ts', how='left')
merged.to_parquet(out_parquet)
