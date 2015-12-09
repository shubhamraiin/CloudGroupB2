#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir writeTest
dd if=/dev/zero of=writeTest/zerofile bs=$1 count=$2 conv=fdatasync

#start recording write time
startWrite=$(date +%s%N)
$hdfsPath dfs -put writeTest /hdfsWriteTest
returnValue=$?
#stop recording write time
stopWrite=$(date +%s%N)
if [ "$returnValue" == 0 ]
then
	#output the write time
	writeTimeNano=$(($stopWrite-$startWrite))
	writeTime=$(($writeTimeNano/1000000))
	echo "Write Time: $writeTime ms"
	echo "$(($1*$2/1000)), $writeTime" >> hdfsWriteOutput.xls
else
	echo "Error while writing"	
fi
rm -r -f writeTest
$hdfsPath dfs -rm -R /hdfsWriteTest




