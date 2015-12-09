#!/bin/bash
#takes four arguments:
#First: block size, Second: number of blocks
#Third: Random number
#export hdfsPath=/usr/local/hadoop/bin/hdfs
randomNumber=$3
echo "File name to be created: $filename"
#start recording write time
startRead=$(date +%s%3N)
# list files from container
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass list ${randomNumber}ReqGenContainer${randomNumber}
returnValue=$?
#stop recording read time
stopRead=$(date +%s%3N)
if [ "$returnValue" == 0 ]
then
	#output the write time
	listTime=$(($stopRead-$startRead))
	echo "List Time: $listTime ms"
	echo "500 MB, $listTime" >> /home/swift/CustomizedResult/SwiftListContainerFiles.xls
else
	echo "Error while listing"	
fi
