#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#start recording Directory create time
startDirectoryCreate=$(date -u +"%s")

for i in $(seq 1 100)
do
	dirName=/hdfsCreateDirectoryTest+$i
	returnValue=$hdfsPath dfs -mkdir $dirName
done

#stop recording Directory create time
stopDirectoryCreate=$(date -u +"%s")

if [$returnValue=0]
then
	#output the Directory create time
	echo "Directory create time :: $(($stopDirectoryCreate-$startDirectoryCreate)) seconds"
else
	echo "Error while Directory creation"	
fi

