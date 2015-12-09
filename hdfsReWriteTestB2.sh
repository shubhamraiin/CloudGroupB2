#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir writeTest
dd if=/dev/zero of=writeTest/zerofile bs=$1 count=$2 conv=fdatasync
$hdfsPath dfs -put writeTest /hdfsWriteTest

#start recording write time
startWrite=$(date +%s%N)
$hdfsPath dfs -put writeTest /hdfsWriteTest
#stop recording write time
stopWrite=$(date +%s%N)

#output the write time
reWriteTimeNano=$(($stopWrite-$startWrite))
reWriteTime=$(($reWriteTimeNano/1000000)
echo "Re-Write time :: $reWriteTime ms"
echo "$(($1*$2/1000)), $reWriteTime" >> hdfsReWriteOutput.xls
rm -r -f writeTest
$hdfsPath dfs -rm -R /hdfsWriteTest
