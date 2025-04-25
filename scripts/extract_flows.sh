#!/usr/bin/env bash
# usage: extract_flows.sh file.pcap > flows.csv
echo "timestamp,src_ip,dst_ip,proto,length"
tshark -r "$1" -T fields -e frame.time_relative -e ip.src -e ip.dst -e ip.proto -e ip.len -E header=n -E separator=, -E quote=d
