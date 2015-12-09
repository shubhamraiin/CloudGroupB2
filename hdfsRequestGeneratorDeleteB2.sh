#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs
pathVal=$1
fileVal="/${pathVal}/zerofile"
#start recording lookup time
startLookup=$(date +%s%N)
$hdfsPath dfs -rm $fileVal
#stop recording read time
stopLookup=$(date %s%N)

#output the Lookup time
lookupTimeNano=$(($stopLookup-$startLookup))
lookupTime=$(($lookupTimeNano/1000000))
echo "Delete Time: $lookupTime ms"
echo "Delete Time, $lookupTime" >> /home/hduser/Desktop/ReqGenOutput/hdfsListOutput.xls


