#!/bin/bash
#takes three arguments:
#First: block size, Second: number of blocks
#Third: random directory path
export hdfsPath=/usr/local/hadoop/bin/hdfs
filename="zerofile"
echo "File name to be created: $filename"
#create sample file for testing
mkdir writeTest
dd if=/dev/zero of=$filename bs=$1 count=$2 conv=fdatasync
randomDir=$3
$hdfsPath dfs -mkdir -p /$randomDir
echo "random directory path: $randomDir"
#start recording write time
startWrite=$(date +%s%N)
$hdfsPath dfs -put $filename /$randomDir 
returnValue=$?
#stop recording write time
stopWrite=$(date +%s%N)
if [ "$returnValue" == 0 ]
then
	#output the write time
	writeTimeNano=$(($stopWrite-$startWrite))
	writeTime=$(($writeTimeNano/1000000))
	echo "Write Time: $writeTime ms"
	echo "Write Operation(500MB), $writeTime" >> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
else
	echo "Error while writing"	
fi
rm $filename
