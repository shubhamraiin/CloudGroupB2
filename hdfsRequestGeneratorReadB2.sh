#!/bin/bash
#Accepts only one parameter: Random Directory Path
export hdfsPath=/usr/local/hadoop/bin/hdfs
pathVal=$1
fileVal="/${pathVal}/zerofile"
echo "pathVal= $pathVal"
echo "fileVal= $fileVal"
#start recording read time
startRead=$(date +%s%N)
#pathVal="$($hdfsPath dfs -find / -name zerofile)"
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
	echo "Read Operation(500MB), $readTime" >> /home/hduser/Desktop/ReqGenOutput/hdfsReadOutput.xls
else
	echo "Error while reading"	
fi
rm zerofile
