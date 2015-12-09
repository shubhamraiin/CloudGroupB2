#!/bin/bash
#
#This script checks the read time for HDFS
#
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir readTestDir
dd if=/dev/urandom of=readTestDir/randomFile bs=$1 count=$2 conv=fdatasync
$hdfsPath dfs -put readTestDir /hdfsReadTest

#start recording read time
startRead=$(date +%s%N)
pathVal="$($hdfsPath dfs -find / -name randomFile)"
echo "pathVal= $pathVal"
$hdfsPath dfs -get $pathVal
returnValue=$?
#stop recording read time
stopRead=$(date +%s%N)

if [ "$returnValue" == 0 ]
then
	#output the read time
	readTimeNano=$(($stopRead - $startRead))
	readTime=$(($readTimeNano/1000000))
	echo "Read Time: $readTime ms"
	echo "$(($1*$2/1000)), $readTime" >> hdfsReadOutput.xls
else
	echo "Error while reading"	
fi
rm -r -f readTestDir
$hdfsPath dfs -rm -R /hdfsReadTest
rm randomFile
