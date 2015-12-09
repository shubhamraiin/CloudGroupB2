#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs
pathVal=$1

#start recording lookup time
startLookup=$(date +%s%N)
$hdfsPath dfs -ls /$pathVal
#stop recording read time
stopLookup=$(date %s%N)

#output the Lookup time
lookupTimeNano=$(($stopLookup-$startLookup))
lookupTime=$(($lookupTimeNano/1000000))
echo "List Time: $lookupTime ms"
echo "List Time, $lookupTime" >> /home/hduser/Desktop/ReqGenOutput/hdfsListOutput.xls


