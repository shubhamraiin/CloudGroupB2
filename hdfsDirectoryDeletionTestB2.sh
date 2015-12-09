#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#start recording Directory deletion time
startDirectoryDelete=$(date -u +"%s")

for i in $(seq 1 100)
do
	dirName=/hdfsCreateDirectoryTest+$i
	returnValue=$hdfsPath dfs -rm -skipTrash $dirName
done

#stop recording Directory deletion time
stopDirectoryDelete=$(date -u +"%s")

if [$returnValue=0]
then
	#output the Directory deletion time
	echo "Directory deletion time :: $(($stopDirectoryDelete-$startDirectoryDelete)) seconds"
else
	echo "Error while Directory deletion"	
fi

