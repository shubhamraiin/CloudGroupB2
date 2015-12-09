#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir writeTest
dd if=/dev/zero of=writeTest/zerofile bs=$1 count=$2 conv=fdatasync

#put file on $hdfsPath
$hdfsPath dfs -put writeTest /hdfsWriteTest

#start recording lookup time
startLookup=$(date +%s%N)
#$hdfsPath dfs -find /hdfsWriteTest zerofile
$hdfsPath dfs -find / -name largeFile.csv 
#stop recording read time
stopLookup=$(date %s%N)

#output the Lookup time
lookupTimeNano=$(($stopLookup-$startLookup))
lookupTime=$(($lookupTimeNano/1000000))
echo "Lookup time: $lookupTime ms"
echo "Lookup time, $lookupTime" >> hdfsLookupOutput.xls

rm -r -f writeTest
$hdfsPath dfs -rm -R /hdfsWriteTest

