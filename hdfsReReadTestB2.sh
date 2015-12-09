#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir writeTest
dd if=/dev/zero of=writeTest/zerofile bs=$1 count=$2 conv=fdatasync
$hdfsPath dfs -put writeTest /hdfsWriteTest
$hdfsPath dfs -get /hdfsWriteTest/zerofile
rm zerofile

#start recording read time
startRead=$(date +%s%N)
$hdfsPath dfs -get /hdfsWriteTest/zerofile
#stop recording read time
stopRead=$(date +%s%N)

#output the re-read time
reReadTimeNano=$(($stopRead-$startRead))
reReadTime=$(($reReadTimeNano/1000000))
echo "Re-Read time: $reReadTime ms"
echo "$(($1*$2/1000)), $reReadTime" >> hdfsReReadOutput.xls
rm -r -f writeTest
$hdfsPath dfs -rm -R /hdfsWriteTest
rm zerofile
